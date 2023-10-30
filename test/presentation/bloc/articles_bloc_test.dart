import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_and_tdd/core/error/failure.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/article.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_bloc.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_event.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late MockGetArticlesByCategoryUseCase mockGetArticlesByCategoryUseCase;
  late ArticlesBloc articlesBloc;

  setUp(() {
    mockGetArticlesByCategoryUseCase = MockGetArticlesByCategoryUseCase();
    articlesBloc = ArticlesBloc(mockGetArticlesByCategoryUseCase);
  });

  final testArticleEntity = ArticleEntity(
      author: "Chris Isidore, Vanessa Yurkevich",
      title:
      "UAW reaches tentative agreement with Stellantis, expands strike at GM - CNN",
      description:
      "The UAW has reached a tentative agreement with Stellantis, which makes vehicles under the Dodge, Ram, Chrysler and Jeep brands.",
      url:
      "https://www.cnn.com/2023/10/28/business/uaw-stellantis-deal/index.html",
      urlToImage:
      "https://media.cnn.com/api/v1/images/stellar/prod/231027165526-uaw-walk-out-09222023.jpg?c=16x9&q=w_800,c_fill",
      publishedAt: DateTime.parse("2023-10-29T01:51:00Z"),
      content:
      "The United Auto Workers unioncame to a tenative agreement with Stellantis Saturday. But it expanded the strike against General Motors, Americas largest automaker and the last remaining Big Three hold… [+8575 chars]");
  final testArticlesEntity = ArticlesEntity(
      articles: [testArticleEntity], status: "ok", totalResults: 1);

  const String category = "business";
  test('intial state should be articles empty', () {
    expect(articlesBloc.state, ArticlesEmpty());
  });

  blocTest<ArticlesBloc, ArticlesState>(
      'should emit [ArticlesLoading, ArticlesLoaded] when data is gotten',
      build: () {
        when(mockGetArticlesByCategoryUseCase.execute(category)).thenAnswer((
            _) async => Right(testArticlesEntity));
        return articlesBloc;
      },
  act: (bloc) => bloc.add(const OnCategoryChanged(category)),
  expect: () => [ArticlesLoading(), ArticlesLoaded(testArticlesEntity)]);

  blocTest<ArticlesBloc, ArticlesState>(
      'should emit [ArticlesLoading, ArticlesLoadFailure] when server error',
      build: () {
        when(mockGetArticlesByCategoryUseCase.execute(category)).thenAnswer((
            _) async => const Left(ServerFailure("Server failure")));
        return articlesBloc;
      },
      act: (bloc) => bloc.add(const OnCategoryChanged(category)),
      expect: () => [ArticlesLoading(), const ArticlesLoadFailure("Server failure")]);
}
