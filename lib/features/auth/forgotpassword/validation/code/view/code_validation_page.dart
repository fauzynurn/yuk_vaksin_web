import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/base_color.dart';
import 'code_validation_controller.dart';

class CodeValidationPage extends GetView<CodeValidationController> {
  static const routeName = '/reset-password/code-validation';

  const CodeValidationPage({Key? key}) : super(key: key);

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
              Icons.mail,
              size: 54,
              color: blue,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Kode verifikasi berhasil dikirim',
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
              'Kode verifikasi berhasil dikirim ke email',
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
            Text(
              controller.param.email,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: blue,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
                'Silakan masukkan kode verifikasi pada email anda untuk melanjutkan.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: controller.codeTextEditingController,
              validator: controller.isCodeTextFormValid,
              scrollPadding: const EdgeInsets.only(bottom: 100),
              textAlign: TextAlign.center,
              cursorColor: blue,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: blue),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                labelText: 'Kode verifikasi',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: blue),
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: controller.onTapNextButton,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 55, vertical: 8),
                    child: Text(
                      'Lanjut',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                  )),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => TextButton(
                    onPressed: controller.resendCodeRemainingSeconds.value == 0
                        ? controller.onTapResendCode
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 8),
                      child: Text(
                        'Kirim ulang kode verifikasi ${controller.resendCodeRemainingSeconds.value != 0 ? '(${controller.resendCodeRemainingSeconds.value})' : ''}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color:
                              controller.resendCodeRemainingSeconds.value == 0
                                  ? blue
                                  : Colors.white,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        controller.resendCodeRemainingSeconds.value == 0
                            ? Colors.white
                            : Colors.grey[350],
                      ),
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
