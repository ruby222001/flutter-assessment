import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/data/model/author_model.dart';
import 'package:flutter_assessment/data/repositories/author_repository.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final AuthorRepository authorRepo;

  AuthorBloc(this.authorRepo) : super(AuthorInitial()) {
    on<LoadAuthor>((event, emit) async {
      emit(AuthorLoading());
      try {
        final author =await authorRepo.fetchAuthor(event.authorId);
        emit(AuthorListLoaded(author));
      } catch (e) {
        emit(AuthorLoadError(e.toString()));
      }
    });
  }
}
