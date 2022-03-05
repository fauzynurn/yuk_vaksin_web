import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/lat_long.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/location.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/vaccine_place.dart';

import '../../../../core/error.dart';
import '../../../../core/key.dart';

const googleBaseUrl = 'https://maps.googleapis.com/maps/api/';

const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDY3MDk1MTYsIm5hbWUiOiJGYWRoaWwgU2hvZmlhbiIsInJvbGUiOiJ1c2VyIiwic3ViIjoxNn0.igj7CDzhy-Y0ILNnUbCSMXTVwFRMXOWu4mDkeAtWYn4';

class VaccinePlaceDataSourceImpl extends VaccinePlaceDataSource {
  final Dio dio;

  VaccinePlaceDataSourceImpl(this.dio);

  @override
  Future<List<VaccinePlace>> getVaccinePlaceList(
      String startDate, String endDate, int page, int size) async {
    try {
      var response = await dio.get('admin/get-all-event',
          options: Options(headers: {'token': token}),
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
      var x = error;
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<String> getCompleteAddress(double latitude, double longitude) async {
    try {
      var response = await dio.fetch(RequestOptions(
          baseUrl: googleBaseUrl,
          path: 'geocode/json',
          queryParameters: {
            'latlng': '$latitude,$longitude',
            'key': placesApiKey
          }));
      return response.data['results'][0]['formatted_address'];
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }

  @override
  Future<List<Location>> getPlaceList(String query) async {
    try {
      var response = await dio.fetch(RequestOptions(
          path: 'place/autocomplete/json',
          baseUrl: googleBaseUrl,
          queryParameters: {'input': query, 'key': placesApiKey}));
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
      var response = await dio.fetch(RequestOptions(
          baseUrl: googleBaseUrl,
          queryParameters: {'place_id': placeId, 'key': placesApiKey},
          path: 'geocode/json'));
      return LatLong.fromJson(
          response.data['results'][0]['geometry']['location']);
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
      var response = await dio.post('admin/create-vaccine-event',
          options: Options(headers: {'token': token}),
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
          options: Options(headers: {'token': token}),
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
