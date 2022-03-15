import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/dashboard/data/models/vaccine_statistic.dart';

import '../../../core/data_wrapper.dart';
import '../data/datasources/general_datasource.dart';
import '../data/models/dashboard_statistic.dart';

class DashboardController extends GetxController {
  final GeneralDatasource generalDatasource;

  final vaccineStatistic = DataWrapper<VaccineStatistic>.loading().obs;
  final dashboardStatistic = DataWrapper<DashboardStatistic>.loading().obs;

  DashboardController(this.generalDatasource);

  void fetchVaccineStatistic() {
    generalDatasource.getVaccineStatistic().then((value) {
      vaccineStatistic.value = DataWrapper.success(value);
    }, onError: (error) {
      vaccineStatistic.value = DataWrapper.error(error.toString());
    });
  }

  void fetchDashboardStatistic() {
    generalDatasource.getDashboardStatistic().then((value) {
      dashboardStatistic.value = DataWrapper.success(value);
    }, onError: (error) {
      dashboardStatistic.value = DataWrapper.error(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchVaccineStatistic();
    fetchDashboardStatistic();
  }
}
