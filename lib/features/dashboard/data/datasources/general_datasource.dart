import 'package:yuk_vaksin_web/features/dashboard/data/models/dashboard_statistic.dart';

import '../models/vaccine_statistic.dart';

abstract class GeneralDatasource {
  Future<VaccineStatistic> getVaccineStatistic();

  Future<DashboardStatistic> getDashboardStatistic();
}
