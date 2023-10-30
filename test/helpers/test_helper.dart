import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/data_sources/article_remote_data_source.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/repositories/articles_repository.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/usecases/get_articles_by_category.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([ArticleRepository, ArticleRemoteDataSource, GetArticlesByCategoryUseCase],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {

}
