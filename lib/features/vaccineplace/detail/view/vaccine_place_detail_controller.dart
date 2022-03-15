import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_page.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';

import '../../../../core/data_wrapper.dart';
import '../../../home/view/home_page.dart';
import '../../data/models/vaccine_place.dart';
import '../../view/vaccine_place_page.dart';

class VaccinePlaceDetailController extends GetxController {
  final VaccinePlaceDataSource _vaccinePlaceDataSource;
  final sessionList = DataWrapper<List<EventSession>>.loading().obs;

  late VaccinePlace? param;

  VaccinePlaceDetailController(this._vaccinePlaceDataSource);

  void fetchSessionList() {
    sessionList.value = DataWrapper.loading();
    _vaccinePlaceDataSource.getEventSessionList(param!.id).then((value) {
      sessionList.value = DataWrapper.success(value);
    }, onError: (error) {
      sessionList.value = DataWrapper.error(error.toString());
    });
  }

  void onTapSessionItem(EventSession session) {
    Get.toNamed(
        HomePage.routeName +
            VaccinePlacePage.routeName +
            VaccineScheduleSessionDetailPage.routeName,
        arguments: session.id);
  }

  void onTapDeleteSessionItem(EventSession session) async {
    try {
      await _vaccinePlaceDataSource.deleteEventSession(session.id);
      Get.rawSnackbar(title: 'Success', message: 'Sesi berhasil dihapus');
      fetchSessionList();
    } catch (error) {
      Get.rawSnackbar(title: 'Failed', message: 'Sesi gagal dihapus');
    }
  }

  @override
  void onInit() {
    super.onInit();

    param = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    if (param != null) {
      fetchSessionList();
    }
  }
}
