part of 'comments_bloc.dart';

sealed class CommentsEvent {}

//laod comment 
class LoadComment extends CommentsEvent {
  final int postId;
  LoadComment(
    this.postId
  );
}
