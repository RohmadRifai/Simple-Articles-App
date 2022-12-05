import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/features/dashboard/model/article_model.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());

  void fetch() async {
    emit(ArticleFetchInProgress());
    final articles = await Article.fetch();
    emit(ArticleFetchSuccess(datas: articles));
  }
}
