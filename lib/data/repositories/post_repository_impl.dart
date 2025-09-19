import 'package:flutter_assessment/core/config/api_service.dart';
import 'package:flutter_assessment/data/model/post_list_model.dart';
import 'post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiService apiService;

  PostRepositoryImpl(this.apiService);

  @override
  Future<List<PostListModel>> fetchPosts({int page = 1, int limit = 10}) async {
    final data = await apiService.getPostList(page: page, limit: limit);
    return (data as List).map((e) => PostListModel.fromJson(e)).toList();
  }
}
