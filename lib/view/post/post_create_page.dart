import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/post.dart';
import '../../providers/state_noti_provider/post_create_view_model_provider.dart';
import '../../providers/state_noti_provider/post_list_view_model_provider.dart';

class PostCreatePage extends ConsumerStatefulWidget {
  const PostCreatePage({super.key});

  @override
  ConsumerState<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends ConsumerState<PostCreatePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _body = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 제목 입력 필드
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              // 내용 입력 필드
              TextFormField(
                decoration: const InputDecoration(labelText: 'Body'),
                onSaved: (value) {
                  _body = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the body';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              // 포스트 생성 버튼
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // 새로운 포스트 생성
                    final newPost = Post(title: _title, body: _body);
                    // 통신 요청 처리
                    await ref.read(postCreateViewModelProvider.notifier).createPost(_title, _body);

                    // 리스트 상태를 다시 불러오도록 fetchPosts 재호출
                    ref.read(postListViewModelProvider.notifier).fetchPosts();

                    // 생성 후 이전 화면으로 돌아가기
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}