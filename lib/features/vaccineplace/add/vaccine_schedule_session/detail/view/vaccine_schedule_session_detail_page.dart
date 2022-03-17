import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/data/models/user_vaccine_registration.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/upload_certificate_content.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/upload_certificate_controller.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_controller.dart';

import '../../../../../../core/base_color.dart';
import '../../../../../../core/data_wrapper.dart';
import '../../../../../../widgets/loading_indicator.dart';

class VaccineScheduleSessionDetailPage
    extends GetView<VaccineScheduleSessionDetailController> {
  static const routeName = '/event-session-detail';

  const VaccineScheduleSessionDetailPage({Key? key}) : super(key: key);

  void showUploadCertificateDialog(
      UserVaccineRegistration vaccineRegistration, BuildContext context) async {
    Get.find<UploadCertificateController>().vaccineRegistration =
        vaccineRegistration;
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Upload sertifikat',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
              content: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                    maxHeight: 380,
                  ),
                  child: const UploadCertificateContent()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<UploadCertificateController>().onTapSubmitButton();
                    Navigator.pop(context, true);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    Get.delete<UploadCertificateController>();
    if (result!) {
      await Future.delayed(const Duration(seconds: 1));
      controller.fetchUserRegistrationList();
      // Get.find<VaccinePlaceController>().onReceiveAddVaccinePlace();
    }
  }

  Widget userRegistrationTable(BuildContext context) {
    switch (controller.userRegistrationList.value.status) {
      case Status.loading:
        return const Center(
          child: LoadingIndicator(),
        );
      case Status.success:
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor:
                        MaterialStateColor.resolveWith((states) => fadeGrey),
                    dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
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
                        'Nomor Order',
                        style: GoogleFonts.poppins(
                            color: blackGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Nama',
                        style: GoogleFonts.poppins(
                            color: blackGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                    rows: controller.userRegistrationList.value.data!
                        .map((item) => DataRow(cells: [
                              DataCell(item.status == OrderStatus.ordered
                                  ? MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () =>
                                            showUploadCertificateDialog(
                                                item, context),
                                        child: Text('Upload Sertifikat',
                                            style: GoogleFonts.poppins(
                                                color: blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14)),
                                      ),
                                    )
                                  : Text('Selesai',
                                      style: GoogleFonts.poppins(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))),
                              DataCell(Text(
                                item.orderNumber.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 14),
                              )),
                              DataCell(Text(
                                item.username,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 14),
                              )),
                            ]))
                        .toList(),
                  )),
              Obx(() => controller.userRegistrationList.value.data != null &&
                      controller.userRegistrationList.value.data!.isEmpty
                  ? Container(
                      color: Colors.white,
                      width: 643,
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
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => IconButton(
                              onPressed: controller.currentPage.value != 0
                                  ? controller.onTapPreviousPage
                                  : null,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: controller.currentPage.value != 0
                                    ? Colors.black
                                    : grey,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Obx(() => Text(
                                'Page ${controller.currentPage.value + 1}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              )),
                        ),
                        Obx(
                          () => IconButton(
                              onPressed: controller.isLastPageReached.value
                                  ? null
                                  : controller.onTapNextPage,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: controller.isLastPageReached.value
                                    ? grey
                                    : Colors.black,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(204, 201, 201, 1.0)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Obx(() => userRegistrationTable(context)),
                        )),
                  ],
                ))));
  }
}
