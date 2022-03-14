import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccine/add/view/add_vaccine_controller.dart';
import 'package:yuk_vaksin_web/widgets/vertical_title_value.dart';

import '../../../../core/base_color.dart';

class AddVaccineContent extends GetView<AddVaccineController> {
  static const routeName = 'vaccine/add';

  const AddVaccineContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        VerticalTitleValue(
            title: 'Nama Vaksin',
            value: TextFormField(
              controller: controller.nameTextEditingController,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Nama Vaksin',
                labelStyle: TextStyle(
                  color: grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blue),
                ),
              ),
            )),
        const SizedBox(
          height: 8,
        ),
        VerticalTitleValue(
            title: 'Interval',
            value: TextFormField(
              controller: controller.intervalTextEditingController,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Interval (dalam hari)',
                labelStyle: TextStyle(
                  color: grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: blue),
                ),
              ),
            )),
      ],
    );
  }
}
