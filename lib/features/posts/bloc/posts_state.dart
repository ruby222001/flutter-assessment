part of 'posts_bloc.dart';

// @immutable
abstract class PostsState {}

final class PostsInitial extends PostsState {}

//post loading
class PostsLoading extends PostsState {}

//post load
class PostsListLoaded extends PostsState {
  final List<PostListModel> posts;
  final bool hasMore;
  final bool isSearching;

  PostsListLoaded(this.posts, {this.hasMore = true,this.isSearching= true});
}

//post error 
class PostLoadError extends PostsState {
  final String message;

  PostLoadError(this.message);
}
