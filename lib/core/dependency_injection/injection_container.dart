
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/data_sources/article_remote_data_source.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/data/repositories/article_repository_impl.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/repositories/articles_repository.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/domain/usecases/get_articles_by_category.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {

  locator.registerFactory(() => ArticlesBloc(locator()));
  
  locator.registerLazySingleton(() => GetArticlesByCategoryUseCase(locator()));
  
  locator.registerLazySingleton<ArticleRepository>(() =>
  ArticleRepositoryImpl(articleRemoteDataSource: locator()));

  locator.registerLazySingleton<ArticleRemoteDataSource>(() => ArticleRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton(() => http.Client());
}