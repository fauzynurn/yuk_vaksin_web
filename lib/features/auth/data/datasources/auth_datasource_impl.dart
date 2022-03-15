import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import '../../../../core/error.dart';

const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDczMzQ5MTcsIm5hbWUiOiJUZXMgbWFyZXR0dCIsInJvbGUiOiJ1c2VyIiwic3ViIjoyNH0.t_rOCPhJENugmEBF34xA-trtiz1uumBLQobWOJasBVQ';
const usernameKey = 'username';
const tokenKey = 'token';

class AuthDatasourceImpl extends AuthDatasource {
  final Dio dio;
  final SharedPreferences pref;

  AuthDatasourceImpl(this.dio, this.pref);

  @override
  Future<String?> getUserName() => Future.value(pref.getString(usernameKey));

  @override
  Future<String?> getUserToken() => Future.value(pref.getString(tokenKey));

  @override
  Future<void> login(String email, String password) async {
    try {
      var response = await dio.post('admin/login',
          options: Options(headers: {'token': await getUserToken()}),
          data: {'email': email, 'password': password});
      setUserName(response.data!['name']);
      setUserToken(response.data!['token']);
    } on DioError catch (error) {
      throw GeneralException(error.response?.data['errMsg']);
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

  @override
  void setUserName(String value) {
    pref.setString(usernameKey, value);
  }

  @override
  void setUserToken(String value) {
    pref.setString(tokenKey, value);
  }
}
