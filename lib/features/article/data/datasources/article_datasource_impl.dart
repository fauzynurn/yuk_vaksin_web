import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/article/data/datasources/article_datasource.dart';
import 'package:yuk_vaksin_web/features/article/data/models/vaccine_news.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import '../../../../core/error.dart';
import '../../../../core/key.dart';

class ArticleDatasourceImpl extends ArticleDatasource {
  final Dio dio;
  final AuthDatasource authDatasource;

  ArticleDatasourceImpl(this.dio, this.authDatasource);

  @override
  Future<void> createVaccineNews(String title, String shortContent,
      String content, String imageUrl) async {
    try {
      await dio.post('admin/create-article',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {
            'title': title,
            'shortDesc': shortContent,
            'text': content,
            'imgUrl': imageUrl,
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> deleteVaccineNews(int articleId) async {
    try {
      await dio.post('admin/delete-article',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {'id': articleId});
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<VaccineNews>> getVaccineNewsList(int offset, int limit) async {
    try {
      var response = await dio.get('article',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          queryParameters: {'offset': offset, 'limit': limit});

      return (response.data! as List)
          .map((item) => VaccineNews.fromJson(item))
          .toList();
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> updateVaccineNews(int articleId, String title,
      String shortContent, String content, String imageUrl) async {
    try {
      await dio.post('admin/edit-article',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {
            'id': articleId,
            'shortDesc': shortContent,
            'title': title,
            'text': content,
            'imgUrl': imageUrl,
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<String> uploadPhoto(XFile imageFile) async {
    try {
      //await Future.delayed(const Duration(seconds: 1));
      var response = await dio.post('upload',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: FormData.fromMap({
            'image': MultipartFile.fromBytes(
                List.of(await imageFile.readAsBytes()),
                filename: 'image - ${DateTime.now().toString()}'),
          }));
      return response.data['imgUrl'];
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
