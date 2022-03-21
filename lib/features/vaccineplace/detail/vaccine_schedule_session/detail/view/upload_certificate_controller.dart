import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';

import '../data/models/user_vaccine_registration.dart';

class UploadCertificateController extends GetxController {
  late UserVaccineRegistration vaccineRegistration;
  final VaccinePlaceDataSource _vaccinePlaceDataSource;

  UploadCertificateController(this._vaccinePlaceDataSource);

  final pickedImage = Rx<String?>(null);
  final _picker = ImagePicker();

  String pickedImageUrl = '';

  void onTapUploadPhoto() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImageUrl = await _vaccinePlaceDataSource.uploadPhoto(image);
      pickedImage.value = image.path;
    }
  }

  void onTapClosePhoto() {
    pickedImage.value = null;
  }

  void onTapSubmitButton() async {
    try {
      await _vaccinePlaceDataSource.uploadCertificate(
          vaccineRegistration.userId,
          vaccineRegistration.orderId,
          pickedImageUrl);
      Get.rawSnackbar(
          title: 'Success', message: 'Sertifikat berhasil diupload');
    } catch (error) {
      Get.rawSnackbar(
          title: 'Terdapat masalah saat memproses data',
          message: 'Silakan coba lagi');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
