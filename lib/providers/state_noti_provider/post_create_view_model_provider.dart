
// StateNotifierProvider를 정의하여 PostCreateViewModel 인스턴스를 제공합니다.
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post.dart';
import '../../view_models/post_create_view_model.dart';
import '../provider/post_repsitory_provider.dart';

final postCreateViewModelProvider = StateNotifierProvider<PostCreateViewModel, AsyncValue<Post>>((ref) {
  // postRepositoryProvider를 통해 PostRepository 인스턴스를 가져옵니다.
  final postRepository = ref.read(postRepositoryProvider);
  // PostCreateViewModel을 생성하고 반환합니다.
  return PostCreateViewModel(postRepository);
});

/// 이 Provider는 PostCreateViewModel을 관리하여 게시글 생성과 관련된 상태를 유지합니다.
/// ref.read()를 사용하여 필요한 의존성(PostRepository)을 가져와서 ViewModel에 주입합니다.
/// AsyncValue<Post> 타입을 사용하여 비동기 작업의 결과를 관리하며, 로딩, 성공, 실패 상태를 쉽게 처리할 수 있습니다.