part of 'author_bloc.dart';

sealed class AuthorEvent {}
class LoadAuthor extends AuthorEvent {
  final int authorId; 
  LoadAuthor(this.authorId);
}