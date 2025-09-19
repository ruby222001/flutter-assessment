import 'package:flutter_assessment/data/model/comments_model.dart';

abstract class CommentRepository {
  Future<List<Comments>> fetchCommentsForPost(int postId);
}
