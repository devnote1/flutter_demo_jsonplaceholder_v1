import 'package:flutter/material.dart';
import 'package:flutter_demo_jsonplaceholder_v1/providers/state_nofi_provider/post_list_view_model_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/post.dart';

// MVVM -> View는 ViewModel만 바라보면 된다.
// ConsumerWidget Provider의 상태를 구독하여, 상태가 변경될 때 자동으로 UI가 업데이트되도록 합니다
class PostListPage extends ConsumerWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // postViewModelProvider를 통해 ViewModel의 상태(List<Post>)를 구독합니다.
    // 그러면 수동으로 업데이트하지 않아도 자동으로 화면이 갱신됩니다.
    final posts = ref.watch(postListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: posts.isEmpty
          ? const Center(child: Text('No Posts Available')) // 포스트가 없을 경우 메시지를 표시합니다.
          : ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
        ),
        itemCount: posts.length, // 포스트의 개수만큼 리스트 아이템을 생성합니다.
        itemBuilder: (context, index) {
          Post post = posts[index]; // 현재 인덱스의 포스트를 가져옵니다.
          return ListTile(
            title: Text(
              post.title,
              style: const TextStyle(color: Colors.orangeAccent),
            ), // 포스트의 제목을 표시합니다.
            subtitle: Text(post.body), // 포스트의 내용을 표시합니다.
            onTap: () {
              // 포스트를 눌렀을 때의 동작을 정의할 수 있습니다.
              // 예: 포스트 상세 화면으로 이동하거나, 업데이트/삭제 기능을 구현할 수 있습니다.
              Navigator.push(
                context,
                MaterialPageRoute(
                  // 상세보기 화면으로 이동하는 부분은 실제 구현으로 변경 필요
                  builder: (context) => Container(color: Colors.amberAccent),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('삭제'),
                    content: Text('${post.title} 를 삭제 하시겠습니까?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('취소'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('삭제'),
                      ),
                    ],
                  ),
                );
                if (confirm) {
                  // ViewModel의 deletePost 메서드 호출
                  // 상태가 변경되는 행위는 notifier를 통해서 해야 한다.
                  await ref.read(postListViewModelProvider.notifier).deletePost(post.id!);

                  // 삭제 완료 후 스낵바로 피드백 제공
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('포스트 "${post.title}"이(가) 삭제되었습니다.'),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            // 실제 생성 페이지로 변경 필요
            MaterialPageRoute(builder: (context) => Container(color: Colors.orangeAccent)),
          );
        },
        child: const Icon(Icons.add), // 버튼의 아이콘을 설정합니다.
      ),
    );
  }
}
