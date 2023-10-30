import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/article.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/entities/articles.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/usecases/get_articles_by_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  //we wont to check if data from repository is passing to use case unchanged.
  late GetArticlesByCategoryUseCase getArticlesByCategoryUseCase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    getArticlesByCategoryUseCase =
        GetArticlesByCategoryUseCase(mockArticleRepository);
  });

  ArticleEntity testArticleEntity = ArticleEntity(
      author: "Chris Isidore, Vanessa Yurkevich",
      title:
          "UAW reaches tentative agreement with Stellantis, expands strike at GM - CNN",
      description:
          "The UAW has reached a tentative agreement with Stellantis, which makes vehicles under the Dodge, Ram, Chrysler and Jeep brands.",
      url:
          "https://www.cnn.com/2023/10/28/business/uaw-stellantis-deal/index.html",
      urlToImage:
          "https://media.cnn.com/api/v1/images/stellar/prod/231027165526-uaw-walk-out-09222023.jpg?c=16x9&q=w_800,c_fill",
      publishedAt: DateTime.tryParse("2023-10-29T01:51:00Z"),
      content:
          "The United Auto Workers unioncame to a tenative agreement with Stellantis Saturday. But it expanded the strike against General Motors, Americas largest automaker and the last remaining Big Three hold… [+8575 chars]");
  ArticlesEntity testArticlesEntity = ArticlesEntity(
      status: '200', totalResults: 1, articles: [testArticleEntity]);

  const String category = "business";

  test('should get articles for category from repository', () async {
    //arrange
    when(mockArticleRepository.getArticlesByCategory(category))
        .thenAnswer((realInvocation) async => Right(testArticlesEntity));
    //act
    final result = await getArticlesByCategoryUseCase.execute(category);
    //assert
    expect(result, Right(testArticlesEntity));
  });
}
