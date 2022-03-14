import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';

import '../../../../core/data_wrapper.dart';
import '../../data/models/vaccine_place.dart';

class VaccinePlaceDetailController extends GetxController {
  final VaccinePlaceDataSource _vaccinePlaceDataSource;
  final sessionList = DataWrapper<List<EventSession>>.loading().obs;

  late VaccinePlace param;

  VaccinePlaceDetailController(this._vaccinePlaceDataSource);

  void fetchSessionList() {
    _vaccinePlaceDataSource.getEventSessionList(param.id).then((value) {
      sessionList.value = DataWrapper.success(value);
    }, onError: (error) {
      sessionList.value = DataWrapper.error(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();

    param = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    fetchSessionList();
  }
}
