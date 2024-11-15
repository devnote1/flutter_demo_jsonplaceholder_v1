// PostRepositoryImpl의 인스턴스를 제공하는 Riverpod Provider입니다
import 'package:flutter_demo_jsonplaceholder_v1/providers/provider/dio_provider.dart';
import 'package:flutter_demo_jsonplaceholder_v1/repository/post_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// PostRepositoryImpl 객체를 애플리케이션 전역에서 사용할 수 있도록 Riverpod를 통해 제공합니다.
// (ref) { ... }는 익명 함수이며, ref는 Riverpod에서 제공하는 ProviderRef 객체입니다.
// ref를 통해 프로바이더 내에서 다른 프로바이더를 읽거나 라이프사이클을 관리할 수 있습니다.
final postRepositoryProvider = Provider<PostRepositoryImpl>((ref) {
  // ref를 통해 dioProvider에 접근하고 그 객체가 관리하는 Dio 인스턴스를 전달받습니다.
  final dio = ref.read(dioProvider);
  // PostRepositoryImpl를 생성하고 반환합니다.
  return PostRepositoryImpl(dio: dio);
});
