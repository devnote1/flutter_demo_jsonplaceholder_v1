import 'package:flutter_demo_jsonplaceholder_v1/providers/provider/post_repsitory_provider.dart';
import 'package:flutter_demo_jsonplaceholder_v1/view_models/post_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post.dart';

/// PostViewModel의 인스턴스를 제공하는 Riverpod Provider입니다.
/// PostService를 주입받아 ViewModel을 초기화합니다.
final postListViewModelProvider = StateNotifierProvider<PostListViewModel, List<Post>>((ref) {
  // ref 객체를 통해서 postRepositoryProvider
  final _postRepositoryImpl = ref.read(postRepositoryProvider);
  // PostViewModel을 생성하고 반환합니다.
  return PostListViewModel(_postRepositoryImpl);
});

