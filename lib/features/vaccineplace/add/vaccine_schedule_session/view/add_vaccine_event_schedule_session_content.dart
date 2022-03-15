import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';
import 'package:yuk_vaksin_web/widgets/vertical_title_value.dart';

import '../../../../../core/base_color.dart';
import '../../../../vaccine/data/models/vaccine.dart';
import 'add_vaccine_event_schedule_session_controller.dart';

class AddVaccineEventScheduleSessionContent
    extends GetView<AddVaccineEventScheduleSessionController> {
  static const routeName = 'vaccine-event/add';

  const AddVaccineEventScheduleSessionContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalTitleValue(
              title: 'Sesi ke',
              value: TextFormField(
                controller: controller.sessionTextEditingController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Sesi ke',
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
          Obx(
            () => controller.selectedVaccine.value != null
                ? VerticalTitleValue(
                    title: 'Nama vaksin',
                    value: SizedBox(
                      width: double.infinity,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            isExpanded: true,
                            value: controller.selectedVaccine.value!.id,
                            items: controller.vaccineList.value.data!
                                .map<DropdownMenuItem<int>>((Vaccine vaccine) {
                              return DropdownMenuItem<int>(
                                value: vaccine.id,
                                child: Text(vaccine.name),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                controller.onChangeSelectedVaccine(value!),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            height: 8,
          ),
          VerticalTitleValue(
              title: 'Kuota',
              value: TextFormField(
                controller: controller.quotaTextEditingController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Kuota',
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
              title: 'Dosis vaksin ke',
              value: TextFormField(
                controller: controller.vaccineTypeTextEditingController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Dosis vaksin ke',
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
          Row(
            children: [
              Expanded(
                child: VerticalTitleValue(
                    title: 'Tanggal Mulai',
                    value: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            var pickedDate = await showDatePicker(
                              context: context,
                              builder: (context, child) => Theme(
                                  data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: blue)),
                                  child: Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 500,
                                      child: child,
                                    ),
                                  )),
                              initialDate: controller.bottomLimitDate,
                              firstDate: controller.bottomLimitDate,
                              lastDate: controller.topLimitDate,
                            );
                            controller.onChangeStartDate(pickedDate);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => Text(
                                          controller.currentStartDate.value
                                              .toDayMonthYearFormat,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14),
                                        )),
                                    const SizedBox(width: 12),
                                    const Icon(
                                      Icons.today,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )),
                        ))),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: VerticalTitleValue(
                    title: 'Waktu Mulai',
                    value: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            var pickedTime = await showTimePicker(
                              context: context,
                              builder: (context, child) => Theme(
                                  data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: blue)),
                                  child: Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 500,
                                      child: child,
                                    ),
                                  )),
                              initialTime: TimeOfDay.now(),
                            );
                            controller.onChangeStartTime(pickedTime);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => Text(
                                          controller.currentStartTime.value
                                              .format(context),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14),
                                        )),
                                    const SizedBox(width: 12),
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )),
                        ))),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: VerticalTitleValue(
                    title: 'Tanggal Selesai',
                    value: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            var pickedDate = await showDatePicker(
                              context: context,
                              builder: (context, child) => Theme(
                                  data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: blue)),
                                  child: Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 500,
                                      child: child,
                                    ),
                                  )),
                              initialDate: controller.bottomLimitDate,
                              firstDate: controller.bottomLimitDate,
                              lastDate: controller.topLimitDate,
                            );
                            controller.onChangeEndDate(pickedDate);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => Text(
                                          controller.currentEndDate.value
                                              .toDayMonthYearFormat,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14),
                                        )),
                                    const SizedBox(width: 12),
                                    const Icon(
                                      Icons.today,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )),
                        ))),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: VerticalTitleValue(
                    title: 'Waktu Selesai',
                    value: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            var pickedTime = await showTimePicker(
                              context: context,
                              builder: (context, child) => Theme(
                                  data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: blue)),
                                  child: Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 500,
                                      child: child,
                                    ),
                                  )),
                              initialTime: TimeOfDay.now(),
                            );
                            controller.onChangeEndTime(pickedTime);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => Text(
                                          controller.currentEndTime.value
                                              .format(context),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14),
                                        )),
                                    const SizedBox(width: 12),
                                    const Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )),
                        ))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
