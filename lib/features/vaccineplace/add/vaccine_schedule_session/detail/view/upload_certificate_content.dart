import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/vaccine_schedule_session/detail/view/upload_certificate_controller.dart';

import '../../../../../../core/base_color.dart';

class UploadCertificateContent extends GetView<UploadCertificateController> {
  const UploadCertificateContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pickedImage.value == null ||
            controller.pickedImageUrl.isEmpty
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: controller.onTapUploadPhoto,
              child: Container(
                width: 600,
                height: 400,
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.image,
                          color: grey,
                          size: 32,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          'Klik untuk upload foto',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: grey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ))
        : Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              pickedImage(),
            ],
          ));
  }

  Widget pickedImage() => Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: [
          Image.network(
            controller.pickedImage.value!,
            width: 600,
            height: 360,
            fit: BoxFit.contain,
          ),
          Positioned(
            right: -10,
            top: -10,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: controller.onTapClosePhoto,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: blackGrey, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.close,
                    color: grey,
                    size: 12,
                  ),
                ),
              ),
            ),
          )
        ],
      );
}
