import 'package:get/get.dart';

import '../../data/datasources/article_datasource.dart';
import 'article_detail_controller.dart';

class ArticleDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      // Bind.put<VaccinePlaceDataSource>(
      //     VaccinePlaceDataSourceImpl(Get.find<Dio>())),
      // Bind.lazyPut(
      //         () => AddVaccinePlaceController(Get.find<VaccinePlaceDataSource>())),
      Bind.put<ArticleDetailController>(
        ArticleDetailController(Get.find<ArticleDatasource>()),
      )
    ];
  }
}
