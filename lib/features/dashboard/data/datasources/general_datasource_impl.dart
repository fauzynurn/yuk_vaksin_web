import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';
import 'package:yuk_vaksin_web/features/dashboard/data/datasources/general_datasource.dart';
import 'package:yuk_vaksin_web/features/dashboard/data/models/dashboard_statistic.dart';
import 'package:yuk_vaksin_web/features/dashboard/data/models/vaccine_statistic.dart';

import '../../../../core/error.dart';

class GeneralDatasourceImpl extends GeneralDatasource {
  final Dio dio;
  final AuthDatasource authDatasource;

  GeneralDatasourceImpl(this.dio, this.authDatasource);

  @override
  Future<DashboardStatistic> getDashboardStatistic() async {
    try {
      var response = await dio.get(
        'admin/statistic',
        options: Options(
          headers: {'token': await authDatasource.getUserToken()},
        ),
      );
      return DashboardStatistic.fromJson(response.data);
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<VaccineStatistic> getVaccineStatistic() async {
    try {
      var response = await dio.fetch(RequestOptions(
          baseUrl: 'https://covid19.mathdro.id/api/countries/', path: 'ID'));
      return VaccineStatistic.fromJson(response.data);
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
