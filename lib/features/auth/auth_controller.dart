import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AuthMode { login, register }

class AuthController extends GetxController {
  final _isPasswordHidden = true.obs;
  final _isLoading = false.obs;

  final mode = AuthMode.login.obs;

  bool get isPasswordHidden => _isPasswordHidden.value;

  bool get isLoading => _isLoading.value;

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
        await Future.delayed(Duration(seconds: 1));
        _isLoading.value = false;
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
