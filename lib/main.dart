import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yuk_vaksin_web/features/article/view/article_binding.dart';
import 'package:yuk_vaksin_web/features/dashboard/view/dashboard_binding.dart';
import 'package:yuk_vaksin_web/features/home/view/home_binding.dart';
import 'package:yuk_vaksin_web/features/vaccine/view/vaccine_binding.dart';
import 'package:yuk_vaksin_web/features/vaccine/view/vaccine_page.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/detail/view/vaccine_place_detail_binding.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/detail/view/vaccine_place_detail_page.dart';
import 'package:yuk_vaksin_web/main_binding.dart';

import 'ensure_auth_middleware.dart';
import 'features/article/detail/view/article_detail_binding.dart';
import 'features/article/detail/view/article_detail_page.dart';
import 'features/article/view/article_page.dart';
import 'features/auth/auth_binding.dart';
import 'features/auth/auth_page.dart';
import 'features/dashboard/view/dashboard_page.dart';
import 'features/home/view/home_page.dart';
import 'features/vaccineplace/add/vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_binding.dart';
import 'features/vaccineplace/add/vaccine_schedule_session/detail/view/vaccine_schedule_session_detail_page.dart';
import 'features/vaccineplace/view/vaccine_place_binding.dart';
import 'features/vaccineplace/view/vaccine_place_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  MainBinding().dependencies();
  // HttpOverrides.global = MyHttpoverrides();
  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const YukVaksinWeb());
}

class YukVaksinWeb extends StatelessWidget {
  const YukVaksinWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: AuthPage.routeName,
        // HomePage.routeName + DashboardPage.routeName,
        defaultTransition: Transition.noTransition,
        // initialBinding: MainBinding(),
        getPages: [
          GetPage(
              name: AuthPage.routeName,
              page: () => const AuthPage(),
              bindings: [AuthBinding()]),
          GetPage(
            preventDuplicates: true,
            name: HomePage.routeName,
            page: () => HomePage(),
            participatesInRootNavigator: true,
            bindings: [HomeBinding()],
            middlewares: [
              //only enter this route when authed
              EnsureAuthMiddleware(),
            ],
            children: [
              GetPage(
                  preventDuplicates: true,
                  name: DashboardPage.routeName,
                  transition: Transition.noTransition,
                  page: () => const DashboardPage(),
                  bindings: [DashboardBinding()]),
              GetPage(
                  preventDuplicates: true,
                  name: VaccinePage.routeName,
                  page: () => const VaccinePage(),
                  bindings: [VaccineBinding()]),
              GetPage(
                  preventDuplicates: true,
                  name: VaccinePlacePage.routeName,
                  transition: Transition.noTransition,
                  page: () => const VaccinePlacePage(),
                  children: [
                    GetPage(
                        name: VaccinePlaceDetailPage.routeName,
                        page: () => const VaccinePlaceDetailPage(),
                        bindings: [
                          VaccinePlaceDetailBinding()
                        ],
                        children: [
                          GetPage(
                            preventDuplicates: true,
                            name: VaccineScheduleSessionDetailPage.routeName,
                            transition: Transition.noTransition,
                            page: () =>
                                const VaccineScheduleSessionDetailPage(),
                            bindings: [VaccineScheduleSessionDetailBinding()],
                          )
                        ]),
                  ],
                  bindings: [
                    VaccinePlaceBinding()
                  ]),
              GetPage(
                preventDuplicates: true,
                name: ArticlePage.routeName,
                transition: Transition.noTransition,
                page: () => const ArticlePage(),
                bindings: [ArticleBinding()],
                children: [
                  GetPage(
                      name: ArticleDetailPage.routeName,
                      page: () => const ArticleDetailPage(),
                      bindings: [ArticleDetailBinding()])
                ],
              ),
            ],
          )
        ]);
  }
}
