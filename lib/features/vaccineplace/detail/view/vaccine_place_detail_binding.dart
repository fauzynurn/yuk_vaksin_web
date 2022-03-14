import 'package:get/get.dart';

import '../../data/datasources/vaccine_place_datasource.dart';
import 'vaccine_place_detail_controller.dart';

class VaccinePlaceDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      // Bind.put<VaccinePlaceDataSource>(
      //     VaccinePlaceDataSourceImpl(Get.find<Dio>())),
      // Bind.lazyPut(
      //         () => AddVaccinePlaceController(Get.find<VaccinePlaceDataSource>())),
      Bind.put<VaccinePlaceDetailController>(
        VaccinePlaceDetailController(Get.find<VaccinePlaceDataSource>()),
      )
    ];
  }
}
