import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/data/model/comments_model.dart';
import 'package:flutter_assessment/data/repositories/comment_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';


class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentRepository commentRepository;

  CommentsBloc(this.commentRepository) : super(CommentsInitial()) {
    on<LoadComment>((event, emit) async {
      emit(CommentLoading());
      try {
        final data = await commentRepository.fetchCommentsForPost(event.postId);
        emit(CommentListLoaded(data));
      } catch (e) {
        emit(CommentError(e.toString()));
      }
    });
  }
}
