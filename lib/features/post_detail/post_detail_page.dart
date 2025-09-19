import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/utils/app_spacing.dart';
import 'package:flutter_assessment/core/widgets/comment_container.dart';
import 'package:flutter_assessment/core/widgets/shimmer.dart';
import 'package:flutter_assessment/features/author/bloc/author_bloc.dart';
import 'package:flutter_assessment/features/comments/bloc/comments_bloc.dart';
import 'package:flutter_assessment/data/model/post_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailPage extends StatelessWidget {
  final PostListModel post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Text(
          'Post detail',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Author detailss
              BlocBuilder<AuthorBloc, AuthorState>(
                builder: (context, state) {
                  if (state is AuthorLoading || state is AuthorInitial) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ShrimmerEffect.rectangular(height: 50),
                    );
                  }
                  //author details
                  else if (state is AuthorListLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.person_2_sharp),
                          ),
                        ),
                        AppSpacing.w5,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.author.username ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(state.author.email ?? ''),
                          ],
                        ),
                      ],
                    );
                  }
                  return Text('Author not found');
                },
              ),
AppSpacing.h10,              
              //post title
              Text(
                post.title ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              AppSpacing.h10, //post body

              Text(post.body ?? ''),
              AppSpacing.h10, Divider(),
              AppSpacing.h10,
              //post comments
              BlocBuilder<CommentsBloc, CommentsState>(
                builder: (context, state) {
                  if (state is CommentsInitial || state is CommentLoading) {
                    return Column(
                      children: List.generate(
                        7,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ShrimmerEffect.rectangular(height: 100),
                        ),
                      ),
                    );
                  } else if (state is CommentListLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //comments section
                        Text(
                          'Comments (${state.comment.length})',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
AppSpacing.h10,              
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.comment.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              //comment container
                              child: CommentContainer(
                                name: state.comment[index].name ?? '',
                                email: state.comment[index].email ?? '',
                                body: state.comment[index].body ?? '',
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return Text('sdsd');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
