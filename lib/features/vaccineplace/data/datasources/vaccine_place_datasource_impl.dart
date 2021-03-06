import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/lat_long.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/location.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/vaccine_place.dart';

import '../../../../core/error.dart';
import '../../../../core/key.dart';
import '../../../auth/data/datasources/auth_datasource.dart';
import '../../detail/vaccine_schedule_session/detail/data/models/user_vaccine_registration.dart';

const googleBaseUrl = 'https://maps.googleapis.com/maps/api/';

class VaccinePlaceDataSourceImpl extends VaccinePlaceDataSource {
  final Dio dio;
  final AuthDatasource authDatasource;

  VaccinePlaceDataSourceImpl(this.dio, this.authDatasource);

  @override
  Future<List<VaccinePlace>> getVaccinePlaceList(
      String startDate, String endDate, int page, int size) async {
    try {
      var response = await dio.get('admin/get-all-event',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          queryParameters: {
            'startDate': startDate,
            'endDate': endDate,
            'offset': page,
            'limit': size
          });
      return (response.data as List)
          .map((item) => VaccinePlace.fromJson(item))
          .toList();
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<String> getCompleteAddress(double latitude, double longitude) async {
    try {
      var response = await dio.get(
        'googleapi/geocode',
        options: Options(
          headers: {'token': await authDatasource.getUserToken()},
          contentType: Headers.jsonContentType,
        ),
        queryParameters: {
          'lat': latitude,
          'long': longitude,
        },
      );
      return response.data['results'][0]['formatted_address'];
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }

  @override
  Future<List<Location>> getPlaceList(String query) async {
    try {
      var response = await dio.get(
        'googleapi/autocomplete',
        options: Options(
          headers: {'token': await authDatasource.getUserToken()},
          contentType: Headers.jsonContentType,
        ),
        queryParameters: {
          'input': query,
        },
      );
      return (response.data['predictions'] as List)
          .map((item) => Location.fromJson(item))
          .toList();
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }

  @override
  Future<LatLong> getLatLong(String placeId) async {
    try {
      var response = await dio.get(
        'googleapi/place',
        options: Options(
          headers: {'token': await authDatasource.getUserToken()},
          contentType: Headers.jsonContentType,
        ),
        queryParameters: {
          'place_id': placeId,
        },
      );
      return LatLong.fromJson(response.data['result']['geometry']['location']);
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }

  @override
  Future<bool> addVaccinePlace(
      String locationName,
      String address,
      double latitude,
      double longitude,
      String startDate,
      String endDate,
      String imageUrl) async {
    try {
      await dio.post('admin/create-vaccine-event',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {
            'locationName': locationName,
            'address': address,
            'latitude': latitude,
            'longitude': longitude,
            'startDate': startDate,
            'endDate': endDate,
            'img': imageUrl
          });
      return true;
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
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

  @override
  Future<void> deleteVaccinePlace(int eventId) async {
    try {
      await dio.post('admin/delete-vaccine-event',
          options:
              Options(headers: {'token': await authDatasource.getUserToken()}),
          data: {
            'eventId': eventId,
          });
    } on DioError catch (error) {
      throw GeneralException(
        error.response?.data['errMsg'],
      );
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<EventSession>> getEventSessionList(
    int eventScheduleId,
    int offset,
    int limit,
  ) async {
    try {
      var response = await dio
          .get('admin/get-all-vaccine-schedule-session/$eventScheduleId',
              options: Options(
                headers: {
                  'token': await authDatasource.getUserToken(),
                },
              ),
              queryParameters: {
            'offset': offset,
            'limit': limit,
          });
      return (response.data as List)
          .map((item) => EventSession.fromJson(item))
          .toList();
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> updateVaccinePlace(
      int vaccinePlaceId,
      String locationName,
      String address,
      double latitude,
      double longitude,
      String startDate,
      String endDate,
      String imageUrl) async {
    try {
      await dio.post('admin/edit-vaccine-event',
          options: Options(
            headers: {'token': await authDatasource.getUserToken()},
          ),
          data: {
            'eventId': vaccinePlaceId,
            'locationName': locationName,
            'address': address,
            'latitude': latitude,
            'longitude': longitude,
            'startDate': startDate,
            'endDate': endDate,
            'img': imageUrl
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> createEventSession(int eventId, int vaccineId, int quota,
      String startTime, String endTime, int session, int vaccineType) async {
    try {
      await dio.post('admin/create-vaccine-event-schedule',
          options: Options(
            headers: {'token': await authDatasource.getUserToken()},
          ),
          data: {
            'eventId': eventId,
            'vaccineId': vaccineId,
            'quota': quota,
            'startTime': startTime,
            'endTime': endTime,
            'session': session,
            'vaccineType': vaccineType,
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> deleteEventSession(int eventScheduleId) async {
    try {
      await dio.post('admin/delete-vaccine-event-schedule',
          options: Options(
            headers: {'token': await authDatasource.getUserToken()},
          ),
          data: {
            'eventScheduleId': eventScheduleId,
          });
    } on DioError catch (error) {
      throw GeneralException(
        error.response?.data['errMsg'],
      );
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> updateEventSession(
      int eventScheduleId,
      int eventId,
      int vaccineId,
      int quota,
      String startTime,
      String endTime,
      int session,
      int vaccineType) async {
    try {
      await dio.post('admin/edit-vaccine-schedule-session',
          options: Options(
            headers: {'token': await authDatasource.getUserToken()},
          ),
          data: {
            'eventScheduleId': eventScheduleId,
            'eventId': eventId,
            'vaccineId': vaccineId,
            'quota': quota,
            'startTime': startTime,
            'endTime': endTime,
            'session': session,
            'vaccineType': vaccineType,
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<UserVaccineRegistration>> getUserVaccineRegistrationList(
    int eventScheduleId,
    int eventId,
    int offset,
    int limit,
    String orderNumber,
  ) async {
    try {
      var response = await dio.get('admin/get-all-order',
          options: Options(
            headers: {'token': await authDatasource.getUserToken()},
          ),
          queryParameters: {
            'eventScheduleId': eventScheduleId,
            'eventId': eventId,
            'offset': offset,
            'limit': limit,
            'orderNo': orderNumber,
          });
      return (response.data as List)
          .map((item) => UserVaccineRegistration.fromJson(item))
          .toList();
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<void> uploadCertificate(
      int userId, int orderId, String certificateUrl) async {
    try {
      await dio.post('admin/create-user-vaccine-detail',
          options: Options(
            headers: {'token': await authDatasource.getUserToken()},
          ),
          data: {
            'userId': userId,
            'orderId': orderId,
            'certificateUrl': certificateUrl
          });
    } on DioError catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
