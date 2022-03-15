import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/upload_certificate_controller.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_controller.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';

class VaccineScheduleSessionDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() =>
          UploadCertificateController(Get.find<VaccinePlaceDataSource>())),
      Bind.put(VaccineScheduleSessionDetailController(
          Get.find<VaccinePlaceDataSource>()))
    ];
  }
}
