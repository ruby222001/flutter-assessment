part of 'posts_bloc.dart';

// @immutable
abstract class PostsEvent {}

//loading post
class LoadPost extends PostsEvent {
  final int page;
  final int limit;
  final bool isRefresh;


  LoadPost({this.page = 1, this.limit = 10, this.isRefresh = false});
}

//search post
class SearchPost extends PostsEvent {
  final String query;
  SearchPost(this.query);
}