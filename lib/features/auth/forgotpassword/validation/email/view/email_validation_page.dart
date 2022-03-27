import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/base_color.dart';
import 'email_validation_controller.dart';

class EmailValidationPage extends GetView<EmailValidationController> {
  static const routeName = '/reset-password/email-validation';

  const EmailValidationPage({Key? key}) : super(key: key);

  Widget content() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              )),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text('Atur Ulang Password',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 24)),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Masukkan email yang sudah terdaftar. '
                  'Sistem akan mengirimkan kode verifikasi ke email anda.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Form(
                  key: controller.formGlobalKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: controller.emailTextEditingController,
                          validator: controller.isEmailTextFormValid,
                          cursorColor: blue,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: blue),
                            ),
                          )),
                      const SizedBox(
                        height: 26,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => TextButton(
                              onPressed: controller.isLoading
                                  ? null
                                  : controller.onTapConfirmButton,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: controller.isLoading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'Konfirmasi',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  controller.isLoading
                                      ? Colors.grey[300]
                                      : blue,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
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
          width: 400,
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
