import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccine/data/datasources/vaccine_datasource.dart';

import '../../../auth/data/datasources/auth_datasource.dart';
import '../../../vaccine/data/datasources/vaccine_datasource_impl.dart';
import '../../data/datasources/vaccine_place_datasource.dart';
import '../vaccine_schedule_session/view/add_vaccine_event_schedule_session_controller.dart';
import 'vaccine_place_detail_controller.dart';

class VaccinePlaceDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      // Bind.put<VaccinePlaceDataSource>(
      //     VaccinePlaceDataSourceImpl(Get.find<Dio>())),
      Bind.put<VaccineDatasource>(
          VaccineDatasourceImpl(Get.find<Dio>(), Get.find<AuthDatasource>())),
      Bind.lazyPut(() => AddVaccineEventScheduleSessionController(
          Get.find<VaccinePlaceDataSource>(), Get.find<VaccineDatasource>())),
      Bind.put<VaccinePlaceDetailController>(
        VaccinePlaceDetailController(Get.find<VaccinePlaceDataSource>()),
      )
    ];
  }
}
