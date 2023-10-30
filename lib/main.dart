import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_and_tdd/core/dependency_injection/injection_container.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_bloc.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/pages/articles_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<ArticlesBloc>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ArticlesPage(),
      ),
    );
  }
}
