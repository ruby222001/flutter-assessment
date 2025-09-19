part of 'comments_bloc.dart';

sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

//comment laoding
class CommentLoading extends CommentsState {}


//loadcomment list
class CommentListLoaded extends CommentsState {
  
  final List<Comments> comment;
  CommentListLoaded(this.comment);
}

//comment error
class CommentError extends CommentsState {
  final String message;

  CommentError(this.message);
}
