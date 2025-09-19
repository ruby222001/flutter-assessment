import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/data/model/post_list_model.dart';
import 'package:flutter_assessment/data/repositories/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepo;

  PostsBloc(this.postRepo) : super(PostsInitial()) {
    on<LoadPost>(onLoadPost);
    on<SearchPost>(onSearchPost);
  }

//
  List<PostListModel> allPosts = [];

//load post 
  Future<void> onLoadPost(LoadPost event, Emitter<PostsState> emit) async {
    try {
      if (event.isRefresh) {
        allPosts.clear();
        emit(PostsLoading());
      }

      final newPosts = await postRepo.fetchPosts(
        page: event.page,
        limit: event.limit,
      );

      allPosts.addAll(newPosts);

      emit(PostsListLoaded(allPosts, hasMore: newPosts.length == event.limit));
    } catch (e) {
      emit(PostLoadError(e.toString()));
    }
  }

//search particular post
  Future<void> onSearchPost(SearchPost event, Emitter<PostsState> emit) async {
    final filtered = allPosts
        .where((post) => post.title!.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(PostsListLoaded(filtered, hasMore: false));
  }
}
