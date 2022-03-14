import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/base_color.dart';
import '../../../core/data_wrapper.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/primary_button.dart';
import '../add/view/add_vaccine_content.dart';
import '../add/view/add_vaccine_controller.dart';
import '../data/models/vaccine.dart';
import 'vaccine_controller.dart';

class VaccinePage extends GetView<VaccineController> {
  static const routeName = '/vaccine';

  const VaccinePage({Key? key}) : super(key: key);

  void showDeleteDialog(Vaccine vaccine, BuildContext context) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Apakah anda yakin akan menghapus jenis vaksin ini?',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
              content: Text(
                'Data vaksin yang dihapus tidak dapat dikembalikan lagi',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.black),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    if (result != null && result) {
      controller.onTapDeleteVaccineItem(vaccine);
    }
  }

  void showAddVaccineDialog(BuildContext context) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Tambah jenis vaksin',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
              content: const SizedBox(
                  width: 700, height: 200, child: AddVaccineContent()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<AddVaccineController>().onTapSubmitButton();
                    Navigator.pop(context, true);
                    Get.rawSnackbar(
                        title: 'Success',
                        message: 'Jenis vaksin berhasil ditambahkan');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    Get.delete<AddVaccineController>();
    if (result!) {
      await Future.delayed(const Duration(seconds: 1));
      controller.fetchVaccineList();
    }
  }

  void showEditVaccineDialog(Vaccine vaccine, BuildContext context) async {
    Get.find<AddVaccineController>().param = vaccine;
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Ubah jenis vaksin',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
              content: const SizedBox(
                  width: 700, height: 600, child: AddVaccineContent()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<AddVaccineController>().onTapSubmitButton();
                    Navigator.pop(context, true);
                    Get.rawSnackbar(
                        title: 'Success',
                        message: 'Jenis vaksin berhasil diubah');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    Get.delete<AddVaccineController>();
    if (result!) {
      await Future.delayed(const Duration(seconds: 1));
      Get.find<VaccineController>().fetchVaccineList();
    }
  }

  Widget body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PrimaryButton(
                    icon: const Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                    onTap: () => showAddVaccineDialog(context),
                    // () => showAddVaccineDialog(context),
                    label: 'Tambah'),
                // Expanded(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Obx(
                //         () => IconButton(
                //             onPressed: controller.currentPage.value != 0
                //                 ? controller.onTapPreviousPage
                //                 : null,
                //             icon: Icon(
                //               Icons.arrow_back_ios,
                //               size: 16,
                //               color: controller.currentPage.value != 0
                //                   ? Colors.black
                //                   : grey,
                //             )),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 16),
                //         child: Obx(() => Text(
                //               'Page ${controller.currentPage.value + 1}',
                //               style: GoogleFonts.poppins(
                //                   fontWeight: FontWeight.normal, fontSize: 12),
                //             )),
                //       ),
                //       Obx(
                //         () => IconButton(
                //             onPressed: controller.isLastPageReached.value
                //                 ? null
                //                 : controller.onTapNextPage,
                //             icon: Icon(
                //               Icons.arrow_forward_ios,
                //               size: 16,
                //               color: controller.isLastPageReached.value
                //                   ? grey
                //                   : Colors.black,
                //             )),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(() => vaccineTable(context)),
          ],
        ),
      );

  Widget vaccineTable(BuildContext context) {
    switch (controller.vaccineList.value.status) {
      case Status.loading:
        return const Center(
          child: LoadingIndicator(),
        );
      case Status.success:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => fadeGrey),
                dataRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                columns: [
                  DataColumn(
                      label: Text(
                    'Aksi',
                    style: GoogleFonts.poppins(
                        color: blackGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                  DataColumn(
                      label: Text(
                    'Nama Vaksin',
                    style: GoogleFonts.poppins(
                        color: blackGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                  DataColumn(
                      label: Text(
                    'Interval',
                    style: GoogleFonts.poppins(
                        color: blackGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                ],
                rows: controller.vaccineList.value.data!
                    .map((item) => DataRow(cells: [
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => showEditVaccineDialog(
                                  item,
                                  context,
                                ),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 24,
                                  color: blue,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              IconButton(
                                onPressed: () =>
                                    showDeleteDialog(item, context),
                                // () =>
                                // showDeleteDialog(item, context),
                                icon: const Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          )),
                          DataCell(Text(
                            item.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14),
                          )),
                          DataCell(Text(
                            '${item.interval.toString()} day',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14),
                          )),
                        ]))
                    .toList()),
          ),
          Obx(() => controller.vaccineList.value.data != null &&
                  controller.vaccineList.value.data!.isEmpty
              ? Container(
                  color: Colors.white,
                  width: 300,
                  height: 30,
                  child: Center(
                    child: Text('No data',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: blackGrey,
                            fontSize: 14)),
                  ),
                )
              : const SizedBox()),
        ]);
      case Status.error:
        return const SizedBox();
      case Status.init:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: body(context)));
  }
}
