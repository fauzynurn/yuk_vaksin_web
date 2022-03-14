import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/article/data/datasources/article_datasource.dart';

import '../../../../core/action_mode.dart';
import '../../data/models/vaccine_news.dart';

class AddArticleController extends GetxController {
  late VaccineNews? param;
  final ArticleDatasource articleDatasource;

  AddArticleController(this.articleDatasource);

  final titleTextEditingController = TextEditingController();
  final shortContentTextEditingController = TextEditingController();
  final contentTextEditingController = TextEditingController();

  final pickedImage = Rx<String?>(null);

  final _picker = ImagePicker();

  var pickedImageUrl = '';

  ActionMode mode = ActionMode.add;

  void onTapUploadPhoto() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var imageUrl = await articleDatasource.uploadPhoto(image);
      pickedImageUrl = imageUrl;
      pickedImage.value = image.path;
    }
  }

  void onTapClosePhoto() {
    pickedImage.value = null;
  }

  void onTapSubmitButton() async {
    try {
      if (mode == ActionMode.add) {
        await articleDatasource.createVaccineNews(
            titleTextEditingController.text,
            shortContentTextEditingController.text,
            contentTextEditingController.text,
            pickedImageUrl);
      } else {
        await articleDatasource.updateVaccineNews(
            param!.id,
            titleTextEditingController.text,
            shortContentTextEditingController.text,
            contentTextEditingController.text,
            pickedImageUrl);
      }
    } catch (error) {
      Get.rawSnackbar(
          title: 'Terdapat masalah dalam memproses data',
          message: 'Silakan coba lagi');
    }
  }

  @override
  void onInit() {
    super.onInit();
    param = Get.arguments;

    if (param != null) {
      titleTextEditingController.text = param!.title;
      shortContentTextEditingController.text = param!.shortDescription;
      contentTextEditingController.text = param!.content;
      pickedImage.value = param!.imageUrl;
      pickedImageUrl = param!.imageUrl;
      mode = ActionMode.edit;
    }
  }
}
