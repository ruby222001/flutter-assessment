import 'package:flutter_assessment/core/theme/appTheme/light_theme.dart';
import 'package:flutter_assessment/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_assessment/data/model/post_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_assessment/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_assessment/features/posts/page/dashboard.dart';
import 'package:flutter_assessment/core/widgets/post_container.dart';

// 1. Create a mock PostsBloc
class MockPostsBloc extends Mock implements PostsBloc {}

class FakePostsEvent extends Fake implements PostsEvent {}

class FakePostsState extends Fake implements PostsState {}

class MockThemeBloc extends Mock implements ThemeBloc {}

class FakeThemeEvent extends Fake implements ThemeEvent {}

class FakeThemeState extends Fake implements ThemeState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePostsEvent());
    registerFallbackValue(FakePostsState());
    registerFallbackValue(FakeThemeEvent());
    registerFallbackValue(FakeThemeState());
  });
  testWidgets('displays post list when PostsListLoaded state is emitted', (
    WidgetTester tester,
  ) async {
    final mockPostsBloc = MockPostsBloc();
    final mockThemeBloc = MockThemeBloc();
    final initialThemeState = ThemeState(themeData: lightMode);
    final loadedState = PostsListLoaded([
      PostListModel(
        id: 1,
        title:
            'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
        body:
            'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto',
      ),
      PostListModel(id: 2, title: 'Post Title 2', body: 'Post body 2'),
    ], hasMore: false);

    when(() => mockPostsBloc.state).thenReturn(loadedState);
    when(() => mockThemeBloc.state).thenReturn(initialThemeState);
    when(
      () => mockPostsBloc.stream,
    ).thenAnswer((_) => Stream.value(loadedState));
when(() => mockThemeBloc.stream).thenAnswer((_) => Stream.value(initialThemeState));

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PostsBloc>.value(value: mockPostsBloc),
            BlocProvider<ThemeBloc>.value(value: mockThemeBloc),
          ],
          child: const Dashboard(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.text(
        'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
      ),
      findsOneWidget,
    );
    expect(find.text('Post Title 2'), findsOneWidget);
    expect(find.byType(PostContainer), findsNWidgets(2));
  });
}
