import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';

import 'auth_controller.dart';
import 'login/login_section.dart';
import 'register/register_section.dart';

class AuthPage extends GetView<AuthController> {
  static const routeName = '/auth';

  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: blue,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/yuk_vaksin_logo.png'),
            const SizedBox(
              height: 65,
            ),
            Obx(() => controller.mode.value == AuthMode.login
                ? const LoginSection()
                : const RegisterSection())
          ],
        )),
      ),
    );
  }
}
