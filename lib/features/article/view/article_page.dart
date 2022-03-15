import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/features/article/view/article_controller.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';

import '../../../core/base_color.dart';
import '../../../core/data_wrapper.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/primary_button.dart';
import '../add/view/add_article_content.dart';
import '../add/view/add_article_controller.dart';
import '../data/models/vaccine_news.dart';

class ArticlePage extends GetView<ArticleController> {
  static const routeName = '/article';

  const ArticlePage({Key? key}) : super(key: key);

  void showDeleteDialog(VaccineNews vaccineNews, BuildContext context) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Apakah anda yakin akan menghapus artikel ini?',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
              content: Text(
                'Artikel yang dihapus tidak dapat dikembalikan lagi',
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
      controller.onTapDeleteArticleItem(vaccineNews);
    }
  }

  void showAddArticleDialog(BuildContext context) async {
    var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'Tambah artikel',
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
                        message: 'Artikel berhasil ditambahkan');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    Get.delete<AddArticleController>();
    if (result!) {
      await Future.delayed(const Duration(seconds: 1));
      controller.fetchArticleList();
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
                    onTap: () => showAddArticleDialog(context),
                    // () => showAddArticleDialog(context),
                    label: 'Tambah'),
                Expanded(
                  child: Row(
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
                                  fontWeight: FontWeight.normal, fontSize: 12),
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
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(() => articleTable(context)),
          ],
        ),
      );

  Widget articleTable(BuildContext context) {
    switch (controller.articleList.value.status) {
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
                    'Judul Artikel',
                    style: GoogleFonts.poppins(
                        color: blackGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                  DataColumn(
                      label: Text(
                    'Deskripsi',
                    style: GoogleFonts.poppins(
                        color: blackGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
                  // DataColumn(
                  //     label: Text(
                  //   'Tanggal Dibuat',
                  //   style: GoogleFonts.poppins(
                  //       color: blackGrey,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600),
                  // )),
                  // DataColumn(
                  //     label: Text(
                  //   'Tanggal Diubah',
                  //   style: GoogleFonts.poppins(
                  //       color: blackGrey,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w600),
                  // )),
                ],
                rows: controller.articleList.value.data!
                    .map((item) => DataRow(cells: [
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () =>
                                    controller.onTapDetailArticleItem(item),
                                icon: const Icon(
                                  Icons.remove_red_eye,
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
                            item.title,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14),
                          )),
                          DataCell(Text(
                            item.shortDescription,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14),
                          )),
                          // DataCell(Text(
                          //   item.createdDate.toDayMonthYearFormat,
                          //   style: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.w500,
                          //       color: Colors.black,
                          //       fontSize: 14),
                          // )),
                          // DataCell(Text(
                          //   item.updatedDate.toDayMonthYearFormat,
                          //   style: GoogleFonts.poppins(
                          //       fontWeight: FontWeight.w500,
                          //       color: Colors.black,
                          //       fontSize: 14),
                          // )),
                        ]))
                    .toList()),
          ),
          Obx(() => controller.articleList.value.data != null &&
                  controller.articleList.value.data!.isEmpty
              ? Container(
                  color: Colors.white,
                  width: 345,
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
