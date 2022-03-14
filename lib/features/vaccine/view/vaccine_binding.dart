import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import '../add/view/add_vaccine_controller.dart';
import '../data/datasources/vaccine_datasource.dart';
import '../data/datasources/vaccine_datasource_impl.dart';
import 'vaccine_controller.dart';

class VaccineBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put<VaccineDatasource>(
          VaccineDatasourceImpl(Get.find<Dio>(), Get.find<AuthDatasource>())),
      Bind.lazyPut(() => AddVaccineController(Get.find<VaccineDatasource>())),
      Bind.put<VaccineController>(
        VaccineController(Get.find<VaccineDatasource>()),
      )
    ];
  }
}
