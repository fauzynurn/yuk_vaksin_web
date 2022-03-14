import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/base_color.dart';
import '../../add/view/add_article_content.dart';
import '../../add/view/add_article_controller.dart';
import '../../view/article_controller.dart';
import 'article_detail_controller.dart';

class ArticleDetailPage extends GetView<ArticleDetailController> {
  static const routeName = '/detail';

  // final VaccinePlace vaccinePlace;

  const ArticleDetailPage({Key? key}) : super(key: key);

  void showEditArticleDialog(BuildContext context) async {
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
              content: const SizedBox(
                  width: 700, height: 600, child: AddArticleContent()),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Get.find<AddArticleController>().onTapSubmitButton();
                    Navigator.pop(context, true);
                    Get.rawSnackbar(
                        title: 'Success',
                        message: 'Tempat vaksin berhasil diubah');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    Get.delete<AddArticleController>();
    if (result!) {
      Navigator.pop(context);
      await Future.delayed(const Duration(seconds: 1));
      Get.find<ArticleController>().fetchArticleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                  onPressed: () => showEditArticleDialog(context),
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
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
                  )),
              const SizedBox(
                height: 12,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(204, 201, 201, 1.0)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              controller.param.imageUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.param.title,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.black)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(controller.param.shortDescription,
                                      style: GoogleFonts.poppins(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(controller.param.content)
                      ],
                    ),
                  )),
            ],
          )),
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
