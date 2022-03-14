import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';

import '../../../../core/data_wrapper.dart';
import '../../data/datasources/article_datasource.dart';
import '../../data/models/vaccine_news.dart';

class ArticleDetailController extends GetxController {
  final ArticleDatasource _articleDatasource;
  final sessionList = DataWrapper<List<EventSession>>.loading().obs;

  late VaccineNews param;

  ArticleDetailController(this._articleDatasource);

  // void fetchSessionList() {
  //   _articleDatasource.getEventSessionList(param.id).then((value) {
  //     sessionList.value = DataWrapper.success(value);
  //   }, onError: (error) {
  //     sessionList.value = DataWrapper.error(error.toString());
  //   });
  // }

  @override
  void onInit() {
    super.onInit();

    param = Get.arguments;
  }
}
