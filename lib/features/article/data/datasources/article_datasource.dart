import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/article/data/models/vaccine_news.dart';

abstract class ArticleDatasource {
  Future<List<VaccineNews>> getVaccineNewsList(int offset, int limit);

  Future<void> createVaccineNews(
      String title, String shortContent, String content, String imageUrl);

  Future<void> deleteVaccineNews(int articleId);

  Future<void> updateVaccineNews(int articleId, String title,
      String shortContent, String content, String imageUrl);

  Future<String> uploadPhoto(XFile imageFile);
}
