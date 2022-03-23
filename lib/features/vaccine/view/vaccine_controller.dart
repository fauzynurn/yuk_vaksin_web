import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/data_wrapper.dart';

import '../data/datasources/vaccine_datasource.dart';
import '../data/models/vaccine.dart';

class VaccineController extends GetxController {
  static int pageSize = 10;

  final currentPage = 0.obs;

  final isLastPageReached = false.obs;

  final VaccineDatasource vaccineDatasource;

  final vaccineList = DataWrapper<List<Vaccine>>.loading().obs;

  VaccineController(this.vaccineDatasource);

  void onTapDeleteVaccineItem(Vaccine vaccine) async {
    try {
      await vaccineDatasource.deleteVaccine(vaccine.id);
      Get.rawSnackbar(title: 'Success', message: 'Jenis vaksin berhasil dihapus');
      fetchVaccineList();
    } catch (error) {
      Get.rawSnackbar(title: 'Failed', message: 'Jenis vaksin gagal dihapus');
    }
  }

  void onTapEditVaccineItem(Vaccine vaccine) {

  }

  void onTapPreviousPage() {
    currentPage.value = currentPage.value - 1;
  }

  void onTapNextPage() {
    currentPage.value = currentPage.value + 1;
  }

  void fetchVaccineList() {
    vaccineList.value = DataWrapper.loading();
    vaccineDatasource
        .getVaccineList()
        .then((value) {
      isLastPageReached.value = value.length < pageSize;
      vaccineList.value = DataWrapper.success(value);
    }, onError: (error) {
      vaccineList.value = DataWrapper.error(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    ever(currentPage, (_) {
      fetchVaccineList();
    });
    fetchVaccineList();
  }
}
