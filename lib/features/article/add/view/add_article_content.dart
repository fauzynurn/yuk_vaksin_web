import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/features/article/add/view/add_article_controller.dart';
import 'package:yuk_vaksin_web/widgets/vertical_title_value.dart';

import '../../../../core/base_color.dart';

class AddArticleContent extends GetView<AddArticleController> {
  static const routeName = 'article/add';

  const AddArticleContent({Key? key}) : super(key: key);

  Widget pickedImage() => Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: [
          Image.network(
            controller.pickedImage.value!,
            width: 180,
            fit: BoxFit.fill,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        VerticalTitleValue(
            title: 'Judul Artikel',
            value: TextFormField(
              controller: controller.titleTextEditingController,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Judul Artikel',
                labelStyle: TextStyle(
                  color: grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blue),
                ),
              ),
            )),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pratinjau konten',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 14, color: blackGrey),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.top,
              controller: controller.shortContentTextEditingController,
              maxLines: 2,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'Pratinjau konten',
                hintStyle: TextStyle(
                  color: grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blue),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Isi Artikel',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 14, color: blackGrey),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                controller: controller.contentTextEditingController,
                maxLines: null,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: 'Isi Artikel',
                  hintStyle: TextStyle(
                    color: grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blue),
                  ),
                ),
              ),
            )
          ],
        )),
        // VerticalTitleValue(
        //     title: 'Isi Artikel',
        //     value: TextFormField(
        //       controller: controller.titleTextEditingController,
        //       maxLines: null,
        //       decoration: const InputDecoration(
        //         floatingLabelBehavior: FloatingLabelBehavior.never,
        //         border: OutlineInputBorder(
        //             borderSide: BorderSide(color: Colors.grey)),
        //         labelText: 'Isi Artikel',
        //         labelStyle: TextStyle(
        //           color: grey,
        //         ),
        //         focusedBorder: OutlineInputBorder(
        //           borderSide: BorderSide(color: blue),
        //         ),
        //       ),
        //     )),
        const SizedBox(
          height: 8,
        ),
        VerticalTitleValue(
            title: 'Upload foto',
            value: Obx(
              () => controller.pickedImage.value == null ||
                      controller.pickedImageUrl.isEmpty
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: controller.onTapUploadPhoto,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
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
                    ),
            ))
      ],
    );
  }
}
