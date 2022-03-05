import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/data_wrapper.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import '../../../utils/date_util.dart';
import '../data/models/vaccine_place.dart';

class VaccinePlaceController extends GetxController {
  static int pageSize = 10;

  final _vaccinePlaceList = DataWrapper<List<VaccinePlace>>.init().obs;

  DataWrapper<List<VaccinePlace>> get vaccinePlaceList =>
      _vaccinePlaceList.value;

  final currentPage = 0.obs;

  final isLastPageReached = false.obs;

  final VaccinePlaceDataSource _vaccinePlaceDataSource;

  final currentStartDate = DateTime.now().obs;

  final currentEndDate = DateTime.now().add(const Duration(days: 14)).obs;

  String get currentDateFilter =>
      '${currentStartDate.value.toDayMonthYearFormat} - ${currentEndDate.value.toDayMonthYearFormat}';

  VaccinePlaceController(this._vaccinePlaceDataSource);

  void onChangeDateFilter(DateTime? startDate, DateTime? endDate) {
    if (startDate != null) {
      currentStartDate.value = startDate;
    }
    if (endDate != null) {
      currentEndDate.value = endDate;
    }
  }

  void onTapPreviousPage() {
    currentPage.value = currentPage.value - 1;
  }

  void onTapNextPage() {
    currentPage.value = currentPage.value + 1;
  }

  void onReceiveAddVaccinePlace() {
    fetchVaccinePlaceList();
  }

  void fetchVaccinePlaceList() {
    _vaccinePlaceList.value = DataWrapper.loading();
    _vaccinePlaceDataSource
        .getVaccinePlaceList(
            currentStartDate.value.toYearMonthDayFormat,
            currentEndDate.value.toYearMonthDayFormat,
            currentPage.value * pageSize,
            pageSize)
        .then((value) {
      isLastPageReached.value = value.length < pageSize;
      _vaccinePlaceList.value = DataWrapper.success(value);
    },
            onError: (error) =>
                _vaccinePlaceList.value = DataWrapper.error(error.toString()));
  }

  @override
  void onReady() {
    super.onReady();

    everAll([currentStartDate, currentEndDate, currentPage], (_) {
      fetchVaccinePlaceList();
    });
    fetchVaccinePlaceList();
  }
}
