import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import '../../../../core/error.dart';

const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDczMzQ5MTcsIm5hbWUiOiJUZXMgbWFyZXR0dCIsInJvbGUiOiJ1c2VyIiwic3ViIjoyNH0.t_rOCPhJENugmEBF34xA-trtiz1uumBLQobWOJasBVQ';

class AuthDatasourceImpl extends AuthDatasource {
  final Dio dio;

  AuthDatasourceImpl(this.dio);

  @override
  Future<String> getUserName() {
    // TODO: implement getUserName
    throw UnimplementedError();
  }

  @override
  Future<String> getUserToken() => Future.value(token);

  @override
  Future<void> login(String email, String password) async {
    try {
      await dio.post('admin/login',
          options: Options(headers: {'token': await getUserToken()}),
          data: {'email': email, 'password': password});
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.post('admin/register',
          options: Options(headers: {'token': await getUserToken()}),
          data: {'name': name, 'email': email, 'password': password});
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
