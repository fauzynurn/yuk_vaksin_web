import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/base_color.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  static const routeName = '/reset-password/reset';

  const ResetPasswordPage({Key? key}) : super(key: key);

  Widget content() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          )),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.vpn_key,
              size: 54,
              color: blue,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Atur ulang password',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Silakan masukkan password baru anda.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 24,
            ),
            Form(
              key: controller.formGlobalKey,
              child: Column(
                children: [
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordTextEditingController,
                      validator: controller.isPasswordTextFormValid,
                      obscureText: controller.isPasswordHidden,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      cursorColor: blue,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            splashRadius: 24,
                            icon: Icon(
                                controller.isPasswordHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: blue),
                            onPressed: controller.onPasswordSuffixTapped),
                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: blue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        labelText: 'Password baru',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide: BorderSide(color: blue),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => TextFormField(
                      controller:
                          controller.passwordConfirmationTextEditingController,
                      validator: controller.isPasswordConfirmationTextFormValid,
                      obscureText: controller.isPasswordConfirmationHidden,
                      scrollPadding: const EdgeInsets.only(bottom: 100),
                      cursorColor: blue,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            splashRadius: 24,
                            icon: Icon(
                                controller.isPasswordConfirmationHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: blue),
                            onPressed:
                                controller.onPasswordConfirmationSuffixTapped),
                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        labelText: 'Konfirmasi password baru',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => TextButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.onTapResetPasswordButton,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 12),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Atur Ulang Password',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          controller.isLoading.value ? Colors.grey[300] : blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: blue,
        child: Center(
            child: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logos/yuk_vaksin_logo.png'),
              const SizedBox(
                height: 65,
              ),
              content(),
            ],
          ),
        )),
      ),
    );
  }
}
