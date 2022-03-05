import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';
import 'package:yuk_vaksin_web/widgets/vertical_title_value.dart';

import '../../data/models/vaccine_place.dart';

class VaccinePlaceDetailContent extends StatelessWidget {
  final VaccinePlace vaccinePlace;

  const VaccinePlaceDetailContent({Key? key, required this.vaccinePlace})
      : super(key: key);

  String get vaccinePlaceDateRange =>
      '${vaccinePlace.startDate.toDayMonthYearFormat} - ${vaccinePlace.endDate.toDayMonthYearFormat}';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalTitleValue(
                  title: 'Nama Tempat',
                  value: Text(
                    vaccinePlace.locationName,
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
                    vaccinePlace.address,
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
                  title: 'Koordinat',
                  value: Text(
                    '-',
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
                  title: 'Jadwal Tempat Vaksin',
                  value: Text(
                    vaccinePlaceDateRange,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )),
        const SizedBox(
          width: 36,
        ),
        Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalTitleValue(
                  title: 'Lokasi dalam map',
                  value: SizedBox(width: 450, height: 230, child: Placeholder()
                      // googleMap()
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: VerticalTitleValue(
                      title: 'Upload foto tempat vaksin',
                      value: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          pickedImage(),
                        ],
                      )),
                )
              ],
            ))
      ],
    );
  }

  Widget pickedImage() => SizedBox(
        width: 180,
        height: 180,
        child: Placeholder(),
      );

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

  Widget twoLinesShimmer() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 24,
            color: Colors.white,
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 50,
            height: 24,
            color: Colors.white,
          ),
        ],
      );
}
