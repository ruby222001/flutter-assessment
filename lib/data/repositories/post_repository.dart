import 'package:flutter_assessment/data/model/post_list_model.dart';

abstract class PostRepository {
  Future<List<PostListModel>> fetchPosts({int page = 1, int limit = 10});
}
