
import 'package:flutter_demo_jsonplaceholder_v1/models/post.dart';
import 'package:flutter_demo_jsonplaceholder_v1/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StateNotifier를 상속받아, 상태를 관리하고 업데이트합니다.
/// AsyncValue<Post> 타입을 사용하여 비동기 데이터를 안전하게 관리할 수 있습니다.
class PostCreateViewModel extends StateNotifier<AsyncValue<Post>> {

  // 핵심 로직은 서버측에 데이터를 송신하고 응답 받는다
  // postRepository 클래스가 필요하다.
  // DI 할 수 있도록 리버팟을 활용해서 쉽게 가져올 수 있다.
  // 사용자가 위 작업을 할 수 있는 UI를 만들 때 사용할 수 있는 데이터(상태)를 관리한다.
  // 1
  //CreatePostViewModel(super.state);
  final PostRepository _postRepository;
  // 2
  // 생성자 ( 부모클래스에서 상태관리 할 수 있도록 초기값을 가지는 객체를 넘겨 주어야 한다.
  PostCreateViewModel(this._postRepository) : super(const AsyncValue.loading());


  // 1. 통신 요청이기 때문에 응답 받는 데이터 타입은 Future 여야 한다.
  // 2. 서버측으로 보낼 데이터를 외부에서 주입 받아야 한다.
  // 반환 타입이 올바르게 수정된 메서드
  Future<void> createPost(String title, String body) async {
    try {
      final newPost = await _postRepository.createPost(Post(title: title, body: body));
      state =  AsyncValue.data(newPost);
    // Stack Trace
    //  코드에서 오류가 발생했을 때 디버깅이 필요하지 않거나, 오류 메시지만으로 충분한 경우에는 스택 트레이스를 사용하지 않아도 됩니다
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      print('오류 메시지: ${e.toString()}');
    }
  }
}