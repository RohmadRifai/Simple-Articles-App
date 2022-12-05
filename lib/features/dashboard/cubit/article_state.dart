part of 'article_cubit.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleFetchInProgress extends ArticleState {}

class ArticleFetchSuccess extends ArticleState {
  final List<Article> datas;

  ArticleFetchSuccess({required this.datas});
}
