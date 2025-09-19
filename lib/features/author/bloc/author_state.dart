part of 'author_bloc.dart';

sealed class AuthorState {}

final class AuthorInitial extends AuthorState {}

// /author data loading
class AuthorLoading extends AuthorState {}

//load author list 
class AuthorListLoaded extends AuthorState {
  
  final Author author;
  AuthorListLoaded(this.author);
}

//author data load error
class AuthorLoadError extends AuthorState {
  final String message;

  AuthorLoadError(this.message);
}
