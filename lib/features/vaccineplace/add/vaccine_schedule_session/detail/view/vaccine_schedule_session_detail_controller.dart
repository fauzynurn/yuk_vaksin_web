import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/data/models/user_vaccine_registration.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';

import '../../../../../../core/data_wrapper.dart';

class VaccineScheduleSessionDetailController extends GetxController {
  late int eventScheduleId;
  static int pageSize = 10;
  final currentPage = 0.obs;
  final isLastPageReached = false.obs;

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

  void fetchUserRegistrationList() {
    vaccinePlaceDataSource
        .getUserVaccineRegistrationList(
            eventScheduleId, currentPage.value * pageSize, pageSize, 0)
        .then((value) {
      userRegistrationList.value = DataWrapper.success(value
          .where((element) => element.status != OrderStatus.cancelled)
          .toList());
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

    eventScheduleId = Get.arguments;
    fetchUserRegistrationList();
  }
}
