
import 'package:dio/dio.dart';
import 'package:flutter_demo_jsonplaceholder_v1/repository/post_repository.dart';
import '../models/post.dart';

class PostRepositoryImpl implements PostRepository {
  final Dio _dio;
  // dio 을 가져올 때 우리가 사용할 수 있는 방법은?
  // 1. 생성자를 통한 주입 (Constructor Injection) - 의존성을 수동으로 관리
  PostRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Post> createPost(Post post) async {
    try {
      final response = await _dio.post(
        '/posts',
        data: post.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('게시글 생성 실패');
      }
    } catch (e) {
      throw Exception("게시글 생성 중 오류 발생: $e");
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      final response = await _dio.delete("/posts/$id");
      if (response.statusCode != 200) {
        throw Exception('게시글 삭제 실패');
      }
    } catch (e) {
      throw Exception('게시글  삭제 중 오류 발생: $e');
    }
  }

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get('/posts');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('게시글  목록 불러오기 실패');
      }
    } catch (e) {
      throw Exception('게시글  목록 불러오는 중 오류 발생: $e');
    }
  }

  @override
  Future<Post> updatePost(Post post) async {
    try {
      final response = await _dio.put(
        '/posts/${post.id}',
        data: post.toJson(),
      );
      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('게시글  업데이트 실패');
      }
    } catch (e) {
      throw Exception('게시글  업데이트 중 오류 발생: $e');
    }
  }

  @override
  Future<Post> fetchPostById(int id) async {
    try {
      final response = await _dio.get('/posts/$id');
      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('게시글 불러오기 실패');
      }
    } catch (e) {
      throw Exception('게시글 불러오는 중 오류 발생: $e');
    }
  }
}
