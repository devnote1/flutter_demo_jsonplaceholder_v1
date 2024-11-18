import 'package:flutter/material.dart';
import 'package:flutter_demo_jsonplaceholder_v1/providers/state_noti_provider/post_detail_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailPage extends ConsumerWidget {
  // 코드 흐름 확인
  // 1. 게시글 리스트에서 특정 상세보기 화면 요청 - 선행( 게시글에 id(pk) 값 필요)
  // 2. 생성자를 통해서 전달 받을 수 있다.
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. 상세 보기 화면을 위해 postId를 전달하여 관련된 ViewModel 상태를 구독합니다.
    // 4. 뷰 모델에서 REST API 요청 (통신요청)
    // 5. T state = 통신을 통해 받은 post() 객체를 담는다.
    final postState = ref.watch(postDetailViewModelProvider(postId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      // postState 상태 값은 AsyncValue<Post> 타입입니다.
      // AsyncValue는 데이터를 로딩 중일 때, 성공적으로 로드되었을 때, 오류가 발생했을 때의 세 가지 상태를 관리합니다.
      body: postState.when(
        data: (post) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(post.body, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
