import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/error.dart';
import '../../../../data/datasources/auth_datasource.dart';
import '../../code/view/code_validation_controller.dart';
import '../../code/view/code_validation_page.dart';

class EmailValidationController extends GetxController {
  final _isLoading = false.obs;
  final AuthDatasource _authDatasource;

  final formGlobalKey = GlobalKey<FormState>();

  var emailTextEditingController = TextEditingController();

  EmailValidationController(this._authDatasource);

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  bool get isLoading => _isLoading.value;

  void onTapBackButton() {
    Get.back();
  }

  String? isEmailTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      if (!GetUtils.isEmail(value!)) {
        return 'Format email salah';
      }
      return null;
    } else {
      return 'Email tidak boleh kosong';
    }
  }

  void showMessage(String title, String message) {
    Get.rawSnackbar(
      title: title,
      message: message,
    );
  }

  void onTapConfirmButton() async {
    try {
      if (formGlobalKey.currentState!.validate()) {
        _isLoading.value = true;
        await _authDatasource.verifyEmail(emailTextEditingController.text);
        _isLoading.value = false;
        Get.toNamed(
          CodeValidationPage.routeName,
          arguments: CodeValidationPageParam(
            email: emailTextEditingController.text,
          ),
        );
      }
    } catch (error) {
      _isLoading.value = false;
      if (error is GeneralException) {
        showMessage('Error', error.message!);
      } else {
        showMessage(
          'Terdapat kesalahan pada aplikasi',
          'Silakan coba lagi',
        );
      }
    }
  }
}
