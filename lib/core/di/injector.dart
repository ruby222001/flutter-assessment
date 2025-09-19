import 'package:flutter_assessment/data/repositories/author_repository_impl.dart';
import 'package:flutter_assessment/data/repositories/comment_repository_impl.dart';
import 'package:flutter_assessment/data/repositories/post_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_assessment/core/config/api_service.dart';

import 'package:flutter_assessment/core/theme/bloc/theme_bloc.dart';

import 'package:flutter_assessment/features/author/bloc/author_bloc.dart';

import 'package:flutter_assessment/features/comments/bloc/comments_bloc.dart';

import 'package:flutter_assessment/features/posts/bloc/posts_bloc.dart';

List<BlocProvider> getGlobalProviders() {
  final apiService = ApiService(); // singletonn

  return [
    //theme
    BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
    //author
    BlocProvider<AuthorBloc>(
      create: (_) => AuthorBloc(AuthorRepositoryImpl(apiService)),
    ),
    //comment
    BlocProvider<CommentsBloc>(
      create: (_) => CommentsBloc(CommentRepositoryImpl(apiService)),
    ),
    //post
    BlocProvider<PostsBloc>(
      create: (_) => PostsBloc(PostRepositoryImpl(apiService))..add(LoadPost()),
      lazy: false,
    ),
  ];
}
