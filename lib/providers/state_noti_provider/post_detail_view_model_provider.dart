

import 'package:flutter_demo_jsonplaceholder_v1/providers/provider/post_repsitory_provider.dart';
import 'package:flutter_demo_jsonplaceholder_v1/view_models/post_detail_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post.dart';

// family 외부 매개변수를 통해 여러 인스턴스를 쉽게 구분하고 관리할 수 있도록 합니다.
// StateNotifierProvider 뷰 모델과 상태 관리(StateNotifier)를 연결하여 UI에서 데이터를 효율적으로 관리 합니다.
final postDetailViewModelProvider = 
  StateNotifierProvider.family<PostDetailViewModel, AsyncValue<Post>, int> ((ref, postId) {

    // postId: family를 통해 전달받은 외부 매개변수로, 특정 포스트를 식별하는 데 사용됩니다.
    final postRepository = ref.read(postRepositoryProvider);

    // 생성자에 postService와 postId를 전달하여 해당 포스트의 상세 정보를 가져올 수 있도록 합니다.
    return PostDetailViewModel(postRepository, postId);
  }); 