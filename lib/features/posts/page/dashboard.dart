import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/config/api_service.dart';
import 'package:flutter_assessment/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_assessment/core/utils/app_spacing.dart';
import 'package:flutter_assessment/core/widgets/post_container.dart';
import 'package:flutter_assessment/core/widgets/shimmer.dart';
import 'package:flutter_assessment/data/repositories/author_repository_impl.dart';
import 'package:flutter_assessment/data/repositories/comment_repository_impl.dart';
import 'package:flutter_assessment/features/author/bloc/author_bloc.dart';
import 'package:flutter_assessment/features/comments/bloc/comments_bloc.dart';
import 'package:flutter_assessment/features/post_detail/post_detail_page.dart';
import 'package:flutter_assessment/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  bool showFab = false;

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadPost(page: _page));

    _scrollController.addListener(() {
      // Pagination
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final state = context.read<PostsBloc>().state;
        if (state is PostsListLoaded && state.hasMore) {
          _page++;
          context.read<PostsBloc>().add(LoadPost(page: _page));
        }
      }

      // Show orhide FAB when scrolled down 300px
      if (_scrollController.offset > 300 && !showFab) {
        setState(() => showFab = true);
      } else if (_scrollController.offset <= 300 && showFab) {
        setState(() => showFab = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: () async {
        _page = 1;
        context.read<PostsBloc>().add(LoadPost(page: _page, isRefresh: true));
      },
      child: Scaffold(
        floatingActionButton: showFab
            ? FloatingActionButton(
                backgroundColor: isDarkMode ? Colors.black : Colors.white,
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                },
                child: Icon(
                  Icons.arrow_upward,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              )
            : null, // initially hidden
        appBar: AppBar(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          title: const Text(
            'Post',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSwitch(
                    value: state.isDarkMode,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ToggleThemeEvent());
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            //search field
            Material(
              color: isDarkMode ? Colors.black : Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search post',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<PostsBloc>().add(SearchPost(value));
                  },
                ),
              ),
            ),
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if (state is PostsInitial || state is PostsLoading) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ShrimmerEffect.rectangular(height: 100),
                        );
                      },
                    ),
                  );
                } else if (state is PostsListLoaded) {
                  //if search post is not found
                  if (state.posts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/empty.png", height: 200),
                            AppSpacing.h10,
                            Text('No post found'),
                          ],
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.posts.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < state.posts.length) {
                          final postItem = state.posts[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (_) => AuthorBloc(
                                            AuthorRepositoryImpl(ApiService()),
                                          )..add(LoadAuthor(postItem.id!)),
                                        ),
                                        BlocProvider(
                                          create: (_) => CommentsBloc(
                                            CommentRepositoryImpl(ApiService()),
                                          )..add(LoadComment(postItem.id!)),
                                        ),
                                      ],

                                      child: PostDetailPage(post: postItem),
                                    ),
                                  ),
                                );
                              },

                              //post container
                              child: PostContainer(
                                title: postItem.title ?? 'Title',
                                body: postItem.body ?? 'body',
                              ),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  );
                }
                return const Center(child: Text('No data'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
