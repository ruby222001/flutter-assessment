import 'package:flutter_assessment/data/model/author_model.dart';

abstract class AuthorRepository {
  Future<Author> fetchAuthor(int id);
}
