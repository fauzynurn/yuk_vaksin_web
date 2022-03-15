import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';
import 'package:yuk_vaksin_web/features/dashboard/view/dashboard_page.dart';

import '../../core/error.dart';
import '../home/view/home_page.dart';

enum AuthMode { login, register }

class AuthController extends GetxController {
  final _isPasswordHidden = true.obs;
  final _isLoading = false.obs;

  final mode = AuthMode.login.obs;

  bool get isPasswordHidden => _isPasswordHidden.value;

  bool get isLoading => _isLoading.value;

  final AuthDatasource authDatasource;

  AuthController(this.authDatasource);

  /// Login
  var loginEmailTextEditingController = TextEditingController();
  var loginPasswordTextEditingController = TextEditingController();

  /// Register
  var registerNameTextEditingController = TextEditingController();
  var registerEmailTextEditingController = TextEditingController();
  var registerPasswordTextEditingController = TextEditingController();

  final loginFormGlobalKey = GlobalKey<FormState>();

  final registerFormGlobalKey = GlobalKey<FormState>();

  void onPasswordSuffixTapped() {
    _isPasswordHidden.value = !(_isPasswordHidden.value);
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  String? isNameTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'Email tidak boleh kosong';
    }
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

  String? isPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'Password tidak boleh kosong';
    }
  }

  void onTapRegisterNowButton() {
    mode.value = AuthMode.register;
  }

  void onTapLoginNowButton() {
    mode.value = AuthMode.login;
  }

  void onTapRegisterButton() async {
    try {
      if (registerFormGlobalKey.currentState!.validate()) {
        _isLoading.value = true;
        await Future.delayed(const Duration(seconds: 1));
        _isLoading.value = false;
        mode.value = AuthMode.login;
        Get.snackbar(
            'Proses registrasi berhasil', 'Silakan login untuk melanjutkan',
            maxWidth: 600, backgroundColor: Colors.white);
        // var user = await _authDatasource.login(emailTextEditingController.text,
        //     passwordTextEditingController.text);
        // _authDatasource.saveUserInfo(user);
        // Get.offNamed(HomePage.routeName);
      }
    } catch (error) {
      _isLoading.value = false;
      // if (error is InvalidCredentialException) {
      //   showMessage('Email atau password salah', 'Silakan coba lagi');
      // } else if (error is UserNotFoundException) {
      //   showMessage('Akun tidak ditemukan',
      //       'Silakan lakukan registrasi terlebih dahulu');
      // } else {
      //   showMessage('Terdapat kesalahan pada aplikasi', 'Silakan coba lagi');
      // }
    }
  }

  void onTapLoginButton() async {
    try {
      if (loginFormGlobalKey.currentState!.validate()) {
        _isLoading.value = true;
        await authDatasource.login(loginEmailTextEditingController.text,
            loginPasswordTextEditingController.text);
        _isLoading.value = false;
        // var user = await _authDatasource.login(emailTextEditingController.text,
        //     passwordTextEditingController.text);
        Get.offNamed(HomePage.routeName + DashboardPage.routeName);
      }
    } catch (error) {
      _isLoading.value = false;
      if (error is GeneralException) {
        Get.rawSnackbar(
            title: 'Login failed',
            message: error.message ?? 'Cannot login to the account');
      }
    }
  }
}
