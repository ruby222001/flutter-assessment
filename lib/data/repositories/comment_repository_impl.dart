import 'package:flutter_assessment/core/config/api_service.dart';

import 'package:flutter_assessment/data/model/comments_model.dart';
import 'comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final ApiService apiService;

  CommentRepositoryImpl(this.apiService);

  @override
  Future<List<Comments>> fetchCommentsForPost(int postId) async {
    final data = await apiService.getPostComment(postId);
    return (data as List).map((e) => Comments.fromJson(e)).toList();
  }
}
