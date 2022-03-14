import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/action_mode.dart';
import '../../data/datasources/vaccine_datasource.dart';
import '../../data/models/vaccine.dart';

class AddVaccineController extends GetxController {
  late Vaccine? param;
  final VaccineDatasource vaccineDatasource;

  AddVaccineController(this.vaccineDatasource);

  final nameTextEditingController = TextEditingController();
  final intervalTextEditingController = TextEditingController();

  ActionMode mode = ActionMode.add;

  void onTapSubmitButton() async {
    try {
      if (mode == ActionMode.add) {
        await vaccineDatasource.createVaccine(
          nameTextEditingController.text,
          int.parse(intervalTextEditingController.text),
        );
      } else {
        await vaccineDatasource.updateVaccine(
          param!.id,
          nameTextEditingController.text,
          int.parse(intervalTextEditingController.text),
        );
      }
    } catch (error) {
      Get.rawSnackbar(
          title: 'Terdapat masalah dalam memproses data',
          message: 'Silakan coba lagi');
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (param != null) {
      nameTextEditingController.text = param!.name;
      intervalTextEditingController.text = param!.interval.toString();
      mode = ActionMode.edit;
    }
  }
}
