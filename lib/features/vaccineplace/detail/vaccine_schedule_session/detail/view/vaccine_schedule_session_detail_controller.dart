import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';

import '../../../../../../core/data_wrapper.dart';
import '../data/models/user_vaccine_registration.dart';

class VaccineScheduleSessionDetailController extends GetxController {
  late VaccineScheduleSessionDetailPageParam param;
  static int pageSize = 10;
  final currentPage = 0.obs;
  final isLastPageReached = false.obs;
  final orderCodeTextEditingController = TextEditingController();

  final VaccinePlaceDataSource vaccinePlaceDataSource;

  VaccineScheduleSessionDetailController(this.vaccinePlaceDataSource);

  final userRegistrationList =
      DataWrapper<List<UserVaccineRegistration>>.loading().obs;

  void onTapNextPage() {
    currentPage.value = currentPage.value + 1;
  }

  void onTapPreviousPage() {
    currentPage.value = currentPage.value - 1;
  }

  void onTapSearchButton() {
    fetchUserRegistrationList();
  }

  void fetchUserRegistrationList() {
    userRegistrationList.value = DataWrapper.loading();
    vaccinePlaceDataSource
        .getUserVaccineRegistrationList(
      param.eventScheduleId,
      param.eventId,
      currentPage.value * pageSize,
      pageSize,
      orderCodeTextEditingController.text,
    )
        .then((value) {
      userRegistrationList.value = DataWrapper.success(
        value
            .where((element) => element.status != OrderStatus.cancelled)
            .toList(),
      );
    }, onError: (error) {
      userRegistrationList.value = DataWrapper.error(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    everAll([currentPage], (_) {
      fetchUserRegistrationList();
    });

    param = Get.arguments;
    fetchUserRegistrationList();
  }
}

class VaccineScheduleSessionDetailPageParam {
  final int eventId;
  final int eventScheduleId;

  VaccineScheduleSessionDetailPageParam(
      {required this.eventId, required this.eventScheduleId});
}
