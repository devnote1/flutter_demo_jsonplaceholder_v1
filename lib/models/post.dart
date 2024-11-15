import 'package:equatable/equatable.dart';

/// Post 데이터를 표현하는 모델 클래스입니다.
/// 서버로부터 받은 JSON 데이터를 Dart 객체로 변환하거나,
/// Dart 객체를 JSON으로 변환할 때 사용됩니다.
/// Equatable을 사용하여 값 기반 비교를 지원합니다.
class Post extends Equatable {
  final int? userId;
  final int? id;
  final String title;
  final String body;

  Post({this.userId, this.id, required this.title, required this.body});

  /// JSON 데이터를 Post 객체로 변환하는 생성자입니다.
  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];

  /// Post 객체를 JSON 데이터로 변환하는 메서드입니다.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  /// Equatable을 사용하여 객체의 값 기반 비교를 지원합니다.
  /// Equatable의 요구사항 -> List<Object?>로 props를 구성해야 합니다.
  /// 각 필드의 값을 포함한 리스트를 반환하여 동등성 판단에 사용합니다.
  @override
  List<Object?> get props => [userId, id, title, body];
}
