import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/error.dart';
import '../../auth_page.dart';
import '../../data/datasources/auth_datasource.dart';

class ResetPasswordController extends GetxController {
  late ResetPasswordPageParam param;
  final AuthDatasource authDatasource;

  ResetPasswordController(this.authDatasource);

  final _isPasswordHidden = true.obs;
  final _isPasswordConfirmationHidden = true.obs;

  final passwordTextEditingController = TextEditingController();
  final passwordConfirmationTextEditingController = TextEditingController();

  bool get isPasswordHidden => _isPasswordHidden.value;

  bool get isPasswordConfirmationHidden => _isPasswordConfirmationHidden.value;

  late Timer timer;

  final resendCodeRemainingSeconds = 60.obs;

  final isLoading = false.obs;

  final formGlobalKey = GlobalKey<FormState>();

  void onPasswordSuffixTapped() {
    _isPasswordHidden.value = !(_isPasswordHidden.value);
  }

  void onPasswordConfirmationSuffixTapped() {
    _isPasswordConfirmationHidden.value =
        !(_isPasswordConfirmationHidden.value);
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

  String? isPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      if (value!.length < 8) {
        return 'Jumlah karakter password minimal 8 karakter';
      }
      return null;
    } else {
      return 'Password tidak boleh kosong';
    }
  }

  String? isPasswordConfirmationTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      if (value != passwordTextEditingController.text) {
        return 'Konfirmasi password tidak sama dengan password';
      }
      return null;
    } else {
      return 'Konfirmasi password tidak boleh kosong';
    }
  }

  void onTapResetPasswordButton() async {
    try {
      if (formGlobalKey.currentState!.validate()) {
        isLoading.value = true;
        await authDatasource.resetPassword(
          param.token,
          passwordTextEditingController.text,
        );
        Get.rawSnackbar(
          title: 'Password berhasil diatur ulang',
          message: 'Silakan masuk menggunakan password baru anda',
        );
        Get.offNamed(
          AuthPage.routeName,
        );
        isLoading.value = false;
      }
    } catch (error) {
      isLoading.value = false;
      if (error is GeneralException) {
        Get.rawSnackbar(
            title: 'Gagal mengatur ulang password', message: error.message);
      } else {
        Get.rawSnackbar(
            title: 'Terdapat masalah dalam memproses data',
            message: 'Silakan coba lagi');
      }
    }
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  String? isCodeTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'Kode konfirmasi tidak boleh kosong';
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

  @override
  void onInit() {
    super.onInit();
    param = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
  }
}

class ResetPasswordPageParam {
  final String token;

  ResetPasswordPageParam({required this.token});
}
