// ViewModel은 UI와 데이터를 연결해주는 역할을 합니다.

import 'package:flutter_demo_jsonplaceholder_v1/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';

// PostListViewModel 클래스는 리버팟의 StateNotifier를 사용하여 상태를 관리하는 역할을 합니다.
// 여기서 상태는 List<Post> 형태로, StateNotifier 를 활용하여 T state 변수로 캡슐화 됩니다.
// 즉 T state 는 List<Post> 타입의 객체들이나 null 상태를 나타냅니다.
// 의존성 주입을 통해 PostRepository를 받아와 데이터를 가져오고 관리합니다.

class PostListViewModel extends StateNotifier<List<Post>> {
  // 통신 요청을 담당하는 PostRepository 객체입니다 (의존성 주입).
  final PostRepository _postRepository;

  // 생성자: PostRepository를 받아와 초기화하고, 인스턴스 생성 시 포스트 데이터를 가져옵니다.
  PostListViewModel(this._postRepository) : super([]) {
    fetchPosts();
  }

  /// 포스트 데이터를 가져와 상태를 업데이트하는 메서드입니다.
  Future<void> fetchPosts() async {
    try {
      // PostRepository를 통해 포스트 데이터를 가져옵니다.
      final posts = await _postRepository.fetchPosts();
      // 가져온 포스트 데이터를 상태에 할당합니다.
      state = posts;
    } catch (e) {
      // 에러가 발생한 경우, 상태를 빈 리스트로 초기화합니다.
      // 추후 에러 상태를 관리할 수 있습니다.
      state = [];
    }
  }

  /// 새로운 포스트를 생성하는 메서드입니다.
  Future<void> createPost(Post post) async {
    try {
      final newPost = await _postRepository.createPost(post);
      // 현재 상태에 새로운 포스트를 추가합니다.
      state = [...state, newPost];
      // StateNotifier는 새로운 객체로 할당될 때만 상태 변경을 감지합니다.
    } catch (e) {
      // 에러가 발생한 경우, 현재는 아무 작업도 하지 않습니다.
      // 추후 에러 상태를 관리할 수 있습니다.
      print("createPost : \$e");
    }
  }

  /// 특정 포스트를 삭제하는 메서드입니다.
  Future<void> deletePost(int id) async {
    try {
      // PostRepository를 통해 포스트를 삭제합니다.
      await _postRepository.deletePost(id);

      // 현재 상태에서 해당 포스트를 제거하고 상태를 업데이트합니다.
      state = state.where((p) => p.id != id).toList();
      print('post 삭제 요청 완료');
    } catch (e) {
      // 에러가 발생한 경우, 현재는 아무 작업도 하지 않습니다.
      // 추후 에러 상태를 관리할 수 있습니다.
      print("deletePost : \$e");
    }
  }
}

/// 위 코드에서 ViewModel은 통신을 담당하는 PostRepository를 생성자 의존 주입으로 전달받습니다. (DIP: Dependency Inversion Principle)
