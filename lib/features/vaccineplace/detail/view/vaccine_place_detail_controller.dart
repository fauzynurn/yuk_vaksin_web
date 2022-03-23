import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/error.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/event_session.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/detail/view/vaccine_place_detail_page.dart';

import '../../../../core/data_wrapper.dart';
import '../../../home/view/home_page.dart';
import '../../data/models/vaccine_place.dart';
import '../../view/vaccine_place_page.dart';
import '../vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_controller.dart';
import '../vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_page.dart';

class VaccinePlaceDetailController extends GetxController {
  final VaccinePlaceDataSource _vaccinePlaceDataSource;
  final sessionList = DataWrapper<List<EventSession>>.loading().obs;

  late VaccinePlace? param;

  static int pageSize = 10;

  final currentPage = 0.obs;

  final isLastPageReached = false.obs;

  VaccinePlaceDetailController(this._vaccinePlaceDataSource);

  void fetchSessionList() {
    sessionList.value = DataWrapper.loading();
    _vaccinePlaceDataSource
        .getEventSessionList(
      param!.id,
      currentPage.value * pageSize,
      pageSize,
    )
        .then((value) {
      isLastPageReached.value = value.length < pageSize;
      sessionList.value = DataWrapper.success(value);
    }, onError: (error) {
      sessionList.value = DataWrapper.error(error.toString());
    });
  }

  void onTapPreviousPage() {
    currentPage.value = currentPage.value - 1;
  }

  void onTapNextPage() {
    currentPage.value = currentPage.value + 1;
  }

  void onTapSessionItem(EventSession session) {
    Get.toNamed(
      HomePage.routeName +
          VaccinePlacePage.routeName +
          VaccinePlaceDetailPage.routeName +
          VaccineScheduleSessionDetailPage.routeName,
      arguments: VaccineScheduleSessionDetailPageParam(
        eventId: param!.id,
        eventScheduleId: session.id,
      ),
    );
  }

  void onTapDeleteSessionItem(EventSession session) async {
    try {
      await _vaccinePlaceDataSource.deleteEventSession(session.id);
      Get.rawSnackbar(
        title: 'Success',
        message: 'Sesi berhasil dihapus',
      );
      fetchSessionList();
    } catch (error) {
      if (error is GeneralException) {
        Get.rawSnackbar(
          title: 'Failed',
          message: error.message,
        );
      } else {
        Get.rawSnackbar(
          title: 'Failed',
          message: 'Sesi gagal dihapus',
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    param = Get.arguments;
    ever(currentPage, (_) {
      fetchSessionList();
    });
  }

  @override
  void onReady() {
    super.onReady();
    if (param != null) {
      fetchSessionList();
    }
  }
}
