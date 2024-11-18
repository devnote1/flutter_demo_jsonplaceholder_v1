
import 'package:flutter_demo_jsonplaceholder_v1/models/post.dart';
import 'package:flutter_demo_jsonplaceholder_v1/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateNotifier를 상속받아, 상태를 관리하고 업데이트합니다.
/// AsyncValue<Post> 타입을 사용하여 비동기 데이터를 안전하게 관리할 수 있습니다.
class PostDetailViewModel extends StateNotifier<AsyncValue<Post>> {
  final PostRepository _postService; // 포스트 데이터를 가져오기 위한 레포지토리
  final int postId; // 특정 포스트의 ID를 저장

  PostDetailViewModel(this._postService, this.postId)
      : super(const AsyncValue.loading()) {
    // 생성자 호출시 특정 게시글에 id값을 가져와서 get 요청 처리
    fetchPost();
    // 메소드 안에서 state 변수에다가 값을 저장 시킨다.
  }

  /// 특정 포스트 데이터를 서버로부터 가져오는 메서드입니다.
  /// 비동기 요청이 완료되면 상태를 업데이트합니다.
  Future<void> fetchPost() async {
    try {
      final post = await _postService.fetchPostById(postId);
      state = AsyncValue.data(post);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}