import 'package:dio/dio.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccine/data/datasources/vaccine_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccine/data/models/vaccine.dart';

import '../../../../core/error.dart';

class VaccineDatasourceImpl extends VaccineDatasource {
  final Dio dio;
  final AuthDatasource authDatasource;

  VaccineDatasourceImpl(this.dio, this.authDatasource);

  @override
  Future<void> createVaccine(String vaccineName, int interval) async {
    try {
      await dio.post('admin/create-vaccine-type',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {'name': vaccineName, 'interval': interval});
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> deleteVaccine(int vaccineId) async {
    try {
      await dio.post('admin/delete-vaccine-type',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {'vaccineTypeId': vaccineId});
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<Vaccine>> getVaccineList() async {
    try {
      var response = await dio.get(
        'admin/get-all-vaccine-type',
        options:
            Options(headers: {'token': await authDatasource.getUserToken()}),
      );
      return (response.data as List)
          .map((item) => Vaccine.fromJson(item))
          .toList();
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> updateVaccine(
      int vaccineId, String vaccineName, int interval) async {
    try {
      await dio.post('admin/edit-vaccine-type',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {
            'vaccineTypeId': vaccineId,
            'name': vaccineName,
            'interval': interval
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
