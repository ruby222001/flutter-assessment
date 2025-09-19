import 'package:flutter_assessment/core/config/api_service.dart';
import 'package:flutter_assessment/data/model/author_model.dart';
import 'author_repository.dart';

class AuthorRepositoryImpl implements AuthorRepository {
  final ApiService apiService;

  AuthorRepositoryImpl(this.apiService);

  @override
  Future<Author> fetchAuthor(int id) async {
    final data = await apiService.getAuthorList(id);
    return Author.fromJson(data);
  }
}
