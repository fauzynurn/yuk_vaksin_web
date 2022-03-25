import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/core/data_wrapper.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/lat_long.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/location.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';

import '../../../../core/action_mode.dart';
import '../../data/models/vaccine_place.dart';

class AddVaccinePlaceController extends GetxController {
  late VaccinePlace? param;

  final VaccinePlaceDataSource _vaccinePlaceDataSource;

  AddVaccinePlaceController(this._vaccinePlaceDataSource);

  final placeTextEditingController = TextEditingController();

  final location = Rx<Location?>(null);

  final currentStartDate = DateTime.now().obs;

  final currentEndDate = DateTime.now().add(const Duration(days: 14)).obs;

  final address = DataWrapper<String>.init().obs;

  final coordinate = DataWrapper<LatLong>.init().obs;

  final pickedImage = Rx<String?>(null);

  final _picker = ImagePicker();

  var pickedImageUrl = '';

  ActionMode mode = ActionMode.add;

  String get latitudeLongitude =>
      '${coordinate.value.data!.latitude}, ${coordinate.value.data!.longitude}';

  String get currentDateFilter =>
      '${currentStartDate.value.toDayMonthYearFormat} - ${currentEndDate.value.toDayMonthYearFormat}';

  void onChangeDateFilter(DateTime? startDate, DateTime? endDate) {
    if (startDate != null) {
      currentStartDate.value = startDate;
    }
    if (endDate != null) {
      currentEndDate.value = endDate;
    }
  }

  String? isPlaceFieldValid(String? value) {
    if (value == null && value!.isEmpty) {
      return 'Lokasi tidak boleh kosong';
    }
    return null;
  }

  void onTapUploadPhoto() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var imageUrl = await _vaccinePlaceDataSource.uploadPhoto(image);
      pickedImageUrl = imageUrl;
      pickedImage.value = image.path;
    }
  }

  void onTapClosePhoto() {
    pickedImage.value = null;
  }

  void onTapSubmitButton() async {
    try {
      if (mode == ActionMode.add) {
        await _vaccinePlaceDataSource.addVaccinePlace(
            placeTextEditingController.text,
            address.value.data!,
            coordinate.value.data!.latitude,
            coordinate.value.data!.longitude,
            currentStartDate.value.toYearMonthDayFormat,
            currentEndDate.value.toYearMonthDayFormat,
            pickedImageUrl);
      } else {
        await _vaccinePlaceDataSource.updateVaccinePlace(
            param!.id,
            placeTextEditingController.text,
            address.value.data!,
            coordinate.value.data!.latitude,
            coordinate.value.data!.longitude,
            currentStartDate.value.toYearMonthDayFormat,
            currentEndDate.value.toYearMonthDayFormat,
            pickedImageUrl);
      }
    } catch (error) {
      Get.rawSnackbar(
          title: 'Terdapat masalah dalam memproses data',
          message: 'Silakan coba lagi');
    }
  }

  void onSelectLocation(Location value) {
    location.value = value;
    placeTextEditingController.text = value.name;
  }

  void processLocationId() async {
    address.value = DataWrapper.loading();
    coordinate.value = DataWrapper.loading();

    var latLong = await _vaccinePlaceDataSource.getLatLong(location.value!.id);
    var completeAddress = await _vaccinePlaceDataSource.getCompleteAddress(
        latLong.latitude, latLong.longitude);

    coordinate.value = DataWrapper.success(latLong);
    address.value = DataWrapper.success(completeAddress);
  }

  Future<List<Location>> fetchLocationList(String query) async {
    return await _vaccinePlaceDataSource.getPlaceList(
      query.replaceAll(' ', '%20'),
    );
  }

  @override
  void onInit() {
    super.onInit();
    param = Get.arguments;
    placeTextEditingController.addListener(() {
      if (placeTextEditingController.text.isEmpty) {
        address.value = DataWrapper.init();
        coordinate.value = DataWrapper.init();
      }
    });
    ever(location, (_) {
      processLocationId();
    });
    if (param != null) {
      placeTextEditingController.text = param!.locationName;
      address.value = DataWrapper.success(param!.address);
      coordinate.value = DataWrapper.success(
          LatLong(latitude: param!.latitude, longitude: param!.longitude));
      currentStartDate.value = param!.startDate.toCompleteDate;
      currentEndDate.value = param!.endDate.toCompleteDate;
      pickedImage.value = param!.imageUrl;
      pickedImageUrl = param!.imageUrl;
      mode = ActionMode.edit;
    }
  }
}
