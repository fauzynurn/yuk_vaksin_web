import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/data_wrapper.dart';
import 'package:yuk_vaksin_web/features/article/data/datasources/article_datasource.dart';
import 'package:yuk_vaksin_web/features/article/data/models/vaccine_news.dart';

import '../../home/view/home_page.dart';
import '../../vaccineplace/detail/view/vaccine_place_detail_page.dart';
import '../../vaccineplace/view/vaccine_place_page.dart';
import '../detail/view/article_detail_page.dart';
import 'article_page.dart';

class ArticleController extends GetxController {
  static int pageSize = 10;

  final currentPage = 0.obs;

  final isLastPageReached = false.obs;

  final ArticleDatasource articleDatasource;

  final articleList = DataWrapper<List<VaccineNews>>.loading().obs;

  ArticleController(this.articleDatasource);

  void onTapDeleteArticleItem(VaccineNews vaccineNews) async {
    try {
      await articleDatasource.deleteVaccineNews(vaccineNews.id);
      Get.rawSnackbar(title: 'Success', message: 'Artikel berhasil dihapus');
      fetchArticleList();
    } catch (error) {
      Get.rawSnackbar(title: 'Failed', message: 'Artikel gagal dihapus');
    }
  }

  void onTapDetailArticleItem(VaccineNews vaccineNews) {
    Get.toNamed(
        HomePage.routeName +
            ArticlePage.routeName +
            ArticleDetailPage.routeName,
        arguments: vaccineNews);
  }

  void onTapPreviousPage() {
    currentPage.value = currentPage.value - 1;
  }

  void onTapNextPage() {
    currentPage.value = currentPage.value + 1;
  }

  void fetchArticleList() {
    articleList.value = DataWrapper.loading();
    articleDatasource
        .getVaccineNewsList(currentPage.value * pageSize, pageSize)
        .then((value) {
      isLastPageReached.value = value.length < pageSize;
      articleList.value = DataWrapper.success(value);
    }, onError: (error) {
      articleList.value = DataWrapper.error(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    ever(currentPage, (_) {
      fetchArticleList();
    });
    fetchArticleList();
  }
}
