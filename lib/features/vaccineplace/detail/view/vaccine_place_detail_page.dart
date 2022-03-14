import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';
import 'package:yuk_vaksin_web/widgets/vertical_title_value.dart';

import '../../../../core/data_wrapper.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../add/view/add_vaccine_place_content.dart';
import '../../add/view/add_vaccine_place_controller.dart';
import '../../view/vaccine_place_controller.dart';
import 'vaccine_place_detail_controller.dart';

class VaccinePlaceDetailPage extends GetView<VaccinePlaceDetailController> {
  static const routeName = '/detail';

  // final VaccinePlace vaccinePlace;

  const VaccinePlaceDetailPage({Key? key}) : super(key: key);

  String get vaccinePlaceDateRange =>
      '${controller.param.startDate.toDayMonthYearFormat} - ${controller.param.endDate.toDayMonthYearFormat}';

  void showEditVaccinePlaceDialog(BuildContext context) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Ubah tempat vaksin',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
              content: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 1000,
                    minHeight: 200,
                  ),
                  child: const AddVaccinePlaceContent()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<AddVaccinePlaceController>().onTapSubmitButton();
                    Navigator.pop(context, true);
                    Get.rawSnackbar(
                        title: 'Success',
                        message: 'Tempat vaksin berhasil diubah');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    Get.delete<AddVaccinePlaceController>();
    if (result!) {
      Get.back();
      Get.find<VaccinePlaceController>().onReceiveAddVaccinePlace();
    }
  }

  Widget informationSection(BuildContext context) => Container(
        height: 400,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(204, 201, 201, 1.0)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.info,
                          color: Colors.black,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Informasi',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                      onPressed: () => showEditVaccinePlaceDialog(context),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          backgroundColor: MaterialStateProperty.all(blue)),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 14,
                      ),
                      label: Text(
                        'Edit',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white),
                      ))
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    controller.param.imageUrl,
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalTitleValue(
                          title: 'Nama Tempat',
                          value: Text(
                            controller.param.locationName,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        VerticalTitleValue(
                          title: 'Alamat Lengkap',
                          value: Text(
                            controller.param.address,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: VerticalTitleValue(
                        title: 'Tanggal Mulai',
                        value: Text(
                          controller.param.startDate.toDayMonthYearFormat,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: VerticalTitleValue(
                        title: 'Tanggal Selesai',
                        value: Text(
                          controller.param.endDate.toDayMonthYearFormat,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget mapSection() => Container(
      height: 400,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(204, 201, 201, 1.0)),
          color: Colors.white),
      child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Lokasi dalam map',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                VerticalTitleValue(
                  title: 'Latitude Longitude',
                  value: Text(
                    '${controller.param.latitude}, ${controller.param.longitude}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.param.latitude,
                        controller.param.longitude,
                      ),
                      zoom: 15,
                    ),
                    markers: <Marker>{
                      Marker(
                          position: LatLng(
                            controller.param.latitude,
                            controller.param.longitude,
                          ),
                          markerId: const MarkerId("markerId"))
                    },
                  ),
                )
              ])));

  Widget sessionSection() => Container(
      height: 600,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(204, 201, 201, 1.0)),
          color: Colors.white),
      child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.event_note,
                            color: Colors.black,
                            size: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Sesi Terdaftar',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                        onPressed: null,
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(12)),
                            backgroundColor: MaterialStateProperty.all(blue)),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                        label: Text(
                          'Tambah Sesi',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(child: sessionTable())
              ])));

  Widget sessionTable() {
    switch (controller.sessionList.value.status) {
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
                        'Sesi ke-',
                        style: GoogleFonts.poppins(
                            color: blackGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Waktu Mulai',
                        style: GoogleFonts.poppins(
                            color: blackGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                      DataColumn(
                          label: Text(
                        'Waktu Selesai',
                        style: GoogleFonts.poppins(
                            color: blackGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                    ],
                    rows: controller.sessionList.value.data!
                        .map((item) => DataRow(cells: [
                              DataCell(Text('Lihat Detail',
                                  style: GoogleFonts.poppins(
                                      color: blue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14))),
                              DataCell(Text(
                                item.session.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 14),
                              )),
                              DataCell(Text(
                                item.startTime.toCompleteDateTime,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 14),
                              )),
                              DataCell(Text(
                                item.endTime.toCompleteDateTime,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 14),
                              )),
                            ]))
                        .toList(),
                  )),
              Obx(() => controller.sessionList.value.data != null &&
                      controller.sessionList.value.data!.isEmpty
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
        body: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(flex: 1, child: informationSection(context)),
              const SizedBox(
                width: 12,
              ),
              Flexible(flex: 1, child: mapSection())
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(child: Obx(() => sessionSection()))
        ],
      ),
    ));
    // return Center(child: Text('jajajajaaj'));
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Flexible(
    //         flex: 1,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             VerticalTitleValue(
    //               title: 'Nama Tempat',
    //               value: Text(
    //                 controller.param.locationName,
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 18,
    //             ),
    //             VerticalTitleValue(
    //               title: 'Alamat Lengkap',
    //               value: Text(
    //                 controller.param.address,
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 18,
    //             ),
    //             VerticalTitleValue(
    //               title: 'Koordinat',
    //               value: Text(
    //                 '-',
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 18,
    //             ),
    //             VerticalTitleValue(
    //               title: 'Jadwal Tempat Vaksin',
    //               value: Text(
    //                 vaccinePlaceDateRange,
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //             )
    //           ],
    //         )),
    //     const SizedBox(
    //       width: 36,
    //     ),
    //     Flexible(
    //         flex: 1,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             VerticalTitleValue(
    //               title: 'Lokasi dalam map',
    //               value: SizedBox(width: 450, height: 230, child: Placeholder()
    //                   // googleMap()
    //                   ),
    //             ),
    //             const SizedBox(
    //               height: 24,
    //             ),
    //             Expanded(
    //               child: VerticalTitleValue(
    //                   title: 'Upload foto tempat vaksin',
    //                   value: Column(
    //                     children: [
    //                       const SizedBox(
    //                         height: 12,
    //                       ),
    //                       pickedImage(),
    //                     ],
    //                   )),
    //             )
    //           ],
    //         ))
    //   ],
    // );
  }

// Widget pickedImage() => SizedBox(
//       width: 180,
//       height: 180,
//       child: Placeholder(),
//     );

// Stack(
//   clipBehavior: Clip.none,
//   fit: StackFit.passthrough,
//   children: [
//     Image.network(
//       pickedImage.value!,
//       width: 180,
//       fit: BoxFit.fill,
//     ),
//     Positioned(
//       right: -10,
//       top: -10,
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         child: GestureDetector(
//           onTap: onTapClosePhoto,
//           child: Container(
//             padding: const EdgeInsets.all(4),
//             decoration: const BoxDecoration(
//                 color: blackGrey, shape: BoxShape.circle),
//             child: const Icon(
//               Icons.close,
//               color: grey,
//               size: 12,
//             ),
//           ),
//         ),
//       ),
//     )
//   ],
// );

// Widget googleMap() {
//   switch (coordinate.value.status) {
//     case Status.loading:
//       return const SizedBox();
//     case Status.success:
//       return GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(
//             coordinate.value.data!.latitude,
//             coordinate.value.data!.longitude,
//           ),
//           zoom: 15,
//         ),
//         markers: <Marker>{
//           Marker(
//               position: LatLng(
//                 coordinate.value.data!.latitude,
//                 coordinate.value.data!.longitude,
//               ),
//               markerId: const MarkerId("markerId"))
//         },
//       );
//     case Status.error:
//       return const SizedBox();
//     case Status.init:
//       return Container(
//         decoration: const BoxDecoration(
//             color: grey, borderRadius: BorderRadius.all(Radius.circular(12))),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.location_off,
//                 size: 32,
//                 color: blackGrey,
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 'Silakan masukkan nama lokasi \nterlebih dahulu',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w600,
//                     color: blackGrey,
//                     fontSize: 12),
//               )
//             ],
//           ),
//         ),
//       );
//     default:
//       return const SizedBox();
//   }
// }

// Widget twoLinesShimmer() =>
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 100,
//           height: 24,
//           color: Colors.white,
//         ),
//         const SizedBox(
//           height: 12,
//         ),
//         Container(
//           width: 50,
//           height: 24,
//           color: Colors.white,
//         ),
//       ],
//     );
}
