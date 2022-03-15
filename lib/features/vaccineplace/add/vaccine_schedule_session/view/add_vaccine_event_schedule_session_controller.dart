import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/data_wrapper.dart';
import 'package:yuk_vaksin_web/features/vaccine/data/datasources/vaccine_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccine/data/models/vaccine.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/detail/view/vaccine_place_detail_controller.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';

import '../../../../../core/action_mode.dart';
import '../../../data/datasources/vaccine_place_datasource.dart';

class AddVaccineEventScheduleSessionController extends GetxController {
  EventSession? param;
  final VaccinePlaceDataSource vaccinePlaceDatasource;
  final VaccineDatasource vaccineDatasource;

  final vaccineList = DataWrapper<List<Vaccine>>.loading().obs;

  final sessionTextEditingController = TextEditingController();
  final vaccineTypeTextEditingController = TextEditingController();
  final quotaTextEditingController = TextEditingController();
  final currentStartDate = Rx<DateTime>(DateTime.now());
  final currentStartTime = Rx<TimeOfDay>(TimeOfDay.now());
  final currentEndDate = Rx<DateTime>(DateTime.now());
  final currentEndTime = Rx<TimeOfDay>(TimeOfDay.now());
  final selectedVaccine = Rx<Vaccine?>(null);

  AddVaccineEventScheduleSessionController(
      this.vaccinePlaceDatasource, this.vaccineDatasource);

  ActionMode mode = ActionMode.add;

  DateTime get bottomLimitDate {
    return Get.find<VaccinePlaceDetailController>()
        .param!
        .startDate
        .toCompleteDate;
  }

  DateTime get topLimitDate {
    return Get.find<VaccinePlaceDetailController>()
        .param!
        .endDate
        .toCompleteDate;
  }

  void onChangeStartDate(DateTime? dateTime) {
    if (dateTime != null) {
      currentStartDate.value = dateTime;
    }
  }

  void onChangeStartTime(TimeOfDay? time) {
    if (time != null) {
      currentStartTime.value = time;
    }
  }

  void onChangeEndDate(DateTime? dateTime) {
    if (dateTime != null) {
      currentEndDate.value = dateTime;
    }
  }

  void onChangeEndTime(TimeOfDay? time) {
    if (time != null) {
      currentEndTime.value = time;
    }
  }

  void onChangeSelectedVaccine(int index) {
    selectedVaccine.value = vaccineList.value.data![index];
  }

  void onTapSubmitButton() async {
    try {
      var x = Get.find<VaccinePlaceDetailController>().param!.id;

    if (mode == ActionMode.add) {
        await vaccinePlaceDatasource.createEventSession(
          Get.find<VaccinePlaceDetailController>().param!.id,
          selectedVaccine.value!.id,
          int.parse(quotaTextEditingController.text),
          '${currentStartDate.value.toYearMonthDayFormat}  ${MaterialLocalizations.of(Get.context!).formatTimeOfDay(currentStartTime.value, alwaysUse24HourFormat: true)}',
          '${currentEndDate.value.toYearMonthDayFormat} ${MaterialLocalizations.of(Get.context!).formatTimeOfDay(currentEndTime.value, alwaysUse24HourFormat: true)}',
          int.parse(sessionTextEditingController.text),
          int.parse(vaccineTypeTextEditingController.text),
        );
        Get.rawSnackbar(title: 'Success', message: 'Sesi berhasil ditambah');
      } else {
        await vaccinePlaceDatasource.updateEventSession(
          param!.id,
          Get.find<VaccinePlaceDetailController>().param!.id,
          selectedVaccine.value!.id,
          int.parse(quotaTextEditingController.text),
          '${currentStartDate.value.toYearMonthDayFormat} ${MaterialLocalizations.of(Get.context!).formatTimeOfDay(currentStartTime.value, alwaysUse24HourFormat: true)}',
          '${currentEndDate.value.toYearMonthDayFormat} ${MaterialLocalizations.of(Get.context!).formatTimeOfDay(currentEndTime.value, alwaysUse24HourFormat: true)}',
          int.parse(sessionTextEditingController.text),
          int.parse(vaccineTypeTextEditingController.text),
        );
        Get.rawSnackbar(title: 'Success', message: 'Sesi berhasil diubah');
      }
    } catch (error) {
      Get.rawSnackbar(
          title: 'Terdapat masalah dalam memproses data',
          message: 'Silakan coba lagi');
    }
  }

  void fetchVaccineList() {
    vaccineDatasource.getVaccineList().then((value) {
      vaccineList.value = DataWrapper.success(value);
      if (value.isNotEmpty) {
        if (param != null) {
          selectedVaccine.value =
              value.firstWhere((element) => element.name == param!.vaccineName);
        } else {
          selectedVaccine.value = value.first;
        }
      }
    }, onError: (error) {
      vaccineList.value = DataWrapper.error(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    if (param != null) {
      sessionTextEditingController.text = param!.session.toString();
      vaccineTypeTextEditingController.text =
          param!.vaccineType != null ? param!.vaccineType.toString() : '';
      quotaTextEditingController.text = param!.remainingQuota.toString();
      currentStartDate.value = param!.startTime.toCompleteDate;
      currentStartTime.value =
          TimeOfDay.fromDateTime(param!.startTime.toCompleteDate);
      currentEndDate.value = param!.endTime.toCompleteDate;
      currentEndTime.value =
          TimeOfDay.fromDateTime(param!.endTime.toCompleteDate);
      mode = ActionMode.edit;
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (param != null) {
      sessionTextEditingController.text = param!.session.toString();
      vaccineTypeTextEditingController.text =
          param!.vaccineType != null ? param!.vaccineType.toString() : '';
      quotaTextEditingController.text = param!.remainingQuota.toString();
      currentStartDate.value = param!.startTime.toCompleteDate;
      currentStartTime.value =
          TimeOfDay.fromDateTime(param!.startTime.toCompleteDate);
      currentEndDate.value = param!.endTime.toCompleteDate;
      currentEndTime.value =
          TimeOfDay.fromDateTime(param!.endTime.toCompleteDate);
      mode = ActionMode.edit;
    }
    fetchVaccineList();
  }
}
