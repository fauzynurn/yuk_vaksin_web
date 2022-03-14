import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';
import 'package:yuk_vaksin_web/features/home/view/widgets/sidebar_item.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/detail/view/vaccine_place_detail_page.dart';

import '../../article/detail/view/article_detail_page.dart';
import '../../article/view/article_page.dart';
import '../../dashboard/view/dashboard_page.dart';
import '../../vaccine/view/vaccine_page.dart';
import '../../vaccineplace/view/vaccine_place_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const routeName = '/home';

  final title = {
    routeName + DashboardPage.routeName: 'Beranda',
    routeName + VaccinePlacePage.routeName: 'Tempat Vaksin',
    routeName + VaccinePage.routeName: 'Vaksin',
    routeName + ArticlePage.routeName: 'Artikel',
    routeName: 'Beranda',
    routeName + VaccinePlacePage.routeName + VaccinePlaceDetailPage.routeName:
        'Detail Tempat Vaksin',
    routeName + ArticlePage.routeName + ArticleDetailPage.routeName:
        'Detail Artikel'
  };

  HomePage({Key? key}) : super(key: key);

  Widget sideBar(BuildContext context) {
    debugPrint('ROUTESS: ${context.location}');
    return Container(
      decoration:
          BoxDecoration(color: Colors.white, border: Border.all(color: grey)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logos/yuk_vaksin_logo_blue.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'YukVaksin!',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black),
                )
              ],
            ),
            Expanded(
                child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SidebarItem(
                      isSelected: context.location.startsWith(
                          HomePage.routeName + DashboardPage.routeName),
                      icon: Icons.home,
                      onTap: () =>
                          controller.onTapDashboardMenu(context.navigation),
                      label:
                          title[HomePage.routeName + DashboardPage.routeName]!),
                  const SizedBox(
                    height: 12,
                  ),
                  SidebarItem(
                      isSelected: context.location ==
                              HomePage.routeName + VaccinePlacePage.routeName ||
                          context.location.startsWith(HomePage.routeName +
                              VaccinePlacePage.routeName +
                              '/'),
                      icon: Icons.location_on,
                      onTap: () =>
                          controller.onTapVaccinePlaceMenu(context.navigation),
                      label: title[
                          HomePage.routeName + VaccinePlacePage.routeName]!),
                  const SizedBox(
                    height: 12,
                  ),
                  SidebarItem(
                      isSelected: context.location ==
                              HomePage.routeName + VaccinePage.routeName ||
                          context.location.startsWith(
                              HomePage.routeName + VaccinePage.routeName + '/'),
                      icon: Icons.app_registration,
                      onTap: () =>
                          controller.onTapVaccineMenu(context.navigation),
                      label:
                          title[HomePage.routeName + VaccinePage.routeName]!),
                  const SizedBox(
                    height: 12,
                  ),
                  SidebarItem(
                      isSelected: context.location ==
                              HomePage.routeName + ArticlePage.routeName ||
                          context.location.startsWith(
                              HomePage.routeName + ArticlePage.routeName),
                      icon: Icons.article,
                      onTap: () =>
                          controller.onTapArticleMenu(context.navigation),
                      label:
                          title[HomePage.routeName + ArticlePage.routeName]!),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget topBar(String currentRouteName) => Container(
      decoration:
          BoxDecoration(color: Colors.white, border: Border.all(color: grey)),
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title[currentRouteName]!,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Admin',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.black,
                  )
                ],
              )
            ],
          )));

  @override
  Widget build(BuildContext context) {
    return RouterOutlet.builder(
        delegate: Get.nestedKey(null),
        builder: (routerContext) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Row(
              children: [
                sideBar(routerContext),
                Expanded(
                  child: Column(
                    children: [
                      topBar(routerContext.location),
                      Expanded(
                        child: GetRouterOutlet(
                          initialRoute: routeName + DashboardPage.routeName,
                          delegate: Get.nestedKey(null),
                          anchorRoute: routeName,
                          //delegate: Get.nestedKey(Routes.HOME),
                          // key: Get.nestedKey(Routes.HOME),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
