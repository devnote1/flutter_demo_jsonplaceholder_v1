import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// HTTP 통신을 위한 Dio 인스턴스는 굳이 매번
/// 생성할 필요가 없기 때문에, 하나의 싱글톤 인스턴스를
/// 애플리케이션 전역에서 재사용하는 방식이 더 효율적입니다.

// 전역에서 재사용 가능한 Dio 싱글톤 인스턴스를 제공합니다.
// dioProvider <-- 이 변수는 Provider로 정의되어,
// 애플리케이션 전역에서 의존성 주입을 통해 접근할 수 있습니다.
final dioProvider = Provider<Dio>((ref) {
  return _dioInstance;
});

// 애플리케이션 전역에서 사용할 Dio 싱글톤 인스턴스
// _dioInstance는 이 파일 안에서만 사용할 수 있는 private 변수입니다.
final Dio _dioInstance = Dio(BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com', // API의 기본 URL 설정
  connectTimeout: const Duration(seconds: 5), // 연결 시간 초과
  receiveTimeout: const Duration(seconds: 3), // 응답 시간 초과
  validateStatus: (status) => true, // 모든 상태 코드를 허용하여 예외를 발생시키지 않음
  headers: {
    'Content-Type': 'application/json', // 요청 헤더 설정
    // 필요한 경우 'Authorization' 헤더를 추가할 수 있습니다.
  },
));
