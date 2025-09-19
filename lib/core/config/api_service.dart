import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/config/api_interceptor.dart';

class ApiService {

  ApiService._internal();
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;


//get post listt
  Future getPostList({int page = 1, int limit = 10}) async {
    try {
      var option = Options();
      option.headers =  Header.getHeader();
      final res = await Api().get(
        "/posts",
        options: option,
        queryParameters: {"_page": page, "_limit": limit},
      );

      return res.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Bad request: ${e.response?.data}");
      }
      rethrow;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//get author list
  Future getAuthorList(int authorId) async {
    try {
      var option = Options();
      option.headers =  Header.getHeader();
      final res = await Api().get("/users/$authorId", options: option);

      return res.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Bad request: ${e.response?.data}");
      }
      rethrow;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//get post comment
  Future getPostComment(int postId) async {
    try {
      var option = Options();
      option.headers =  Header.getHeader();
      final res = await Api().get("/posts/$postId/comments", options: option);

      return res.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Bad request: ${e.response?.data}");
      }
      rethrow;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
