import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/error.dart';

import '../../../../data/datasources/auth_datasource.dart';
import '../../../view/reset_password_controller.dart';
import '../../../view/reset_password_page.dart';

class CodeValidationController extends GetxController {
  late CodeValidationPageParam param;

  final _isLoading = false.obs;

  final AuthDatasource _authDatasource;

  final codeTextEditingController = TextEditingController();

  late Timer timer;

  final resendCodeRemainingSeconds = 60.obs;

  final isResendCodeButtonLoading = false.obs;

  CodeValidationController(this._authDatasource);

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  bool get isLoading => _isLoading.value;

  String? isCodeTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'Kode konfirmasi tidak boleh kosong';
    }
  }

  void onTapNextButton() {
    if (codeTextEditingController.text.isEmpty) {
      showMessage(
        'Kode konfirmasi tidak boleh kosong',
        'Silakan periksa email anda untuk mendapatkan kode konfirmasi',
      );
    } else {
      Get.toNamed(
        ResetPasswordPage.routeName,
        arguments: ResetPasswordPageParam(
          token: codeTextEditingController.text,
        ),
      );
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (t.tick == 60) {
        t.cancel();
      }
      resendCodeRemainingSeconds.value = resendCodeRemainingSeconds.value - 1;
    });
  }

  void onTapResendCode() async {
    try {
      await _authDatasource.verifyEmail(
        param.email,
      );
      Get.rawSnackbar(
        title: 'Kode verifikasi telah dikirim ulang',
        message: 'Silakan cek kembali di email anda',
      );
      resendCodeRemainingSeconds.value = 60;
      startTimer();
    } catch (error) {
      if (error is GeneralException) {
        Get.rawSnackbar(
            title: 'Terdapat masalah dalam memproses data',
            message: error.message);
      } else {
        Get.rawSnackbar(
            title: 'Terdapat masalah dalam memproses data',
            message: 'Silakan coba lagi');
      }
    }
  }

  void showMessage(String title, String message) {
    Get.rawSnackbar(
      title: title,
      message: message,
    );
  }

  @override
  void onInit() {
    super.onInit();
    param = Get.arguments;
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
  }
}

class CodeValidationPageParam {
  final String email;

  CodeValidationPageParam({
    required this.email,
  });
}
