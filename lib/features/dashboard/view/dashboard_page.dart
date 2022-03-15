import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';
import 'package:yuk_vaksin_web/features/dashboard/view/dashboard_controller.dart';
import 'package:yuk_vaksin_web/utils/currency_formatter.dart';

import '../../../core/data_wrapper.dart';

class DashboardPage extends GetView<DashboardController> {
  static const routeName = '/dashboard';

  const DashboardPage({Key? key}) : super(key: key);

  Widget vaccineStatistic() {
    switch (controller.vaccineStatistic.value.status) {
      case Status.loading:
        return const SizedBox();
      case Status.success:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistik COVID-19',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, color: darkerBlue, fontSize: 28),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.vaccineStatistic.value.data!.positive
                                  .toDouble()
                                  .decimalFormat,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32,
                                  color:
                                      const Color.fromRGBO(229, 180, 55, 1.0)),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Positif',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: darkerBlue,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.vaccineStatistic.value.data!.recovered
                                  .toDouble()
                                  .decimalFormat,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32,
                                  color: Colors.green),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Sembuh',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: darkerBlue,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.vaccineStatistic.value.data!.dead
                                  .toDouble()
                                  .decimalFormat,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32,
                                  color: red),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Meninggal',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: darkerBlue,
                                  fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      case Status.error:
        return const SizedBox();
      case Status.init:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget transactionStatistic() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
            padding: const EdgeInsets.all(36),
            child: Row(
              children: [
                PieChart(
                  dataMap: {
                    'ordered': controller
                        .dashboardStatistic.value.data!.totalOngoingOrder
                        .toDouble(),
                    'done': controller
                        .dashboardStatistic.value.data!.totalFinishedOrder
                        .toDouble(),
                    'cancelled': controller
                        .dashboardStatistic.value.data!.totalCancelledOrder
                        .toDouble(),
                  },
                  animationDuration: const Duration(milliseconds: 800),
                  chartRadius: 180,
                  legendOptions: const LegendOptions(showLegends: false),
                  colorList: const [Colors.yellow, Colors.green, red],
                  initialAngleInDegree: 0,
                  chartType: ChartType.disc,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: false,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Transaksi',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: darkerBlue,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      controller.dashboardStatistic.value.data!.totalOrder
                          .toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: blue,
                          fontSize: 32),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.green,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Selesai: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: darkerBlue,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          controller
                              .dashboardStatistic.value.data!.totalFinishedOrder
                              .toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: darkerBlue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.yellow,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Sedang Berjalan: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: darkerBlue,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          controller
                              .dashboardStatistic.value.data!.totalOngoingOrder
                              .toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: darkerBlue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: red,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Dibatalkan: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: darkerBlue,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          controller.dashboardStatistic.value.data!
                              .totalCancelledOrder
                              .toString(),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: darkerBlue,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )));
  }

  Widget dashboardStatistic() {
    switch (controller.dashboardStatistic.value.status) {
      case Status.loading:
        return const SizedBox();
      case Status.success:
        return IntrinsicHeight(
          child: Row(
            children: [
              Flexible(
                  flex: 2,
                  child: SizedBox(height: 240, child: transactionStatistic())),
              const SizedBox(
                width: 12,
              ),
              Flexible(flex: 1, child: totalVaccinePlace())
            ],
          ),
        );
      case Status.error:
        return const SizedBox();
      case Status.init:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  Widget totalVaccinePlace() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: grey),
          borderRadius: const BorderRadius.all(Radius.circular(14))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                controller.dashboardStatistic.value.data!.totalVaccinePlace
                    .toString(),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 32, color: red),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Tempat Vaksin',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: darkerBlue,
                    fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => vaccineStatistic()),
              const SizedBox(height: 12),
              Obx(() => dashboardStatistic())
            ],
          ),
        ),
      ),
    );
  }
}
