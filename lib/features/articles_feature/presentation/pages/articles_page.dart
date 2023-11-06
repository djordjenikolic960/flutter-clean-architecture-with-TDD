import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_bloc.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_event.dart';
import 'package:flutter_clean_architecture_and_tdd/features/articles_feature/presentation/bloc/article_state.dart';
import 'package:http/http.dart' as http;
class ArticlesPage extends StatelessWidget {
  ArticlesPage({super.key});

  StreamController<double> progressStreamController = StreamController();
  StreamController<bool> downloadCompleteStreamController = StreamController();
  StreamController<String> errorStreamController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SearchBar(
          onSubmitted: (value) {
            BlocProvider.of<ArticlesBloc>(context).add(OnCategoryChanged(value));
          },
        ),
      ),
    ]);
  }



  _buildBody() {
    return BlocBuilder<ArticlesBloc, ArticlesState>(builder: (context, state) {
      if (state is ArticlesEmpty) {
        return const Center(
          child: Text("no data"),
        );
      } else if (state is ArticlesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ArticlesLoadFailure) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is ArticlesLoaded) {
        final articlesEntity = state.result;
        return ListView.builder(
            itemCount: articlesEntity.articles?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: articlesEntity.articles![index]!.urlToImage!.isNotEmpty ? Image.network(articlesEntity.articles?[index]?.urlToImage ?? '', width: MediaQuery.of(context).size.width / 3, height: MediaQuery.of(context).size.width / 3) : Container(width: MediaQuery.of(context).size.width / 3, height: MediaQuery.of(context).size.width / 3),
                title: Text(articlesEntity.articles?[index]?.title ?? ''),
              );
            });
      } else {
        return const SizedBox();
      }
    });
  }
}
