import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import '../add/view/add_article_controller.dart';
import '../data/datasources/article_datasource.dart';
import '../data/datasources/article_datasource_impl.dart';
import 'article_controller.dart';

class ArticleBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put<ArticleDatasource>(
          ArticleDatasourceImpl(Get.find<Dio>(), Get.find<AuthDatasource>())),
      Bind.lazyPut(() => AddArticleController(Get.find<ArticleDatasource>())),
      Bind.put<ArticleController>(
        ArticleController(Get.find<ArticleDatasource>()),
      )
    ];
  }
}
