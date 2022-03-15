import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';
import 'package:yuk_vaksin_web/features/dashboard/data/datasources/general_datasource.dart';
import 'package:yuk_vaksin_web/features/dashboard/data/datasources/general_datasource_impl.dart';
import 'package:yuk_vaksin_web/features/dashboard/view/dashboard_controller.dart';

class DashboardBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put<GeneralDatasource>(
          GeneralDatasourceImpl(Get.find<Dio>(), Get.find<AuthDatasource>())),
      Bind.put(DashboardController(Get.find<GeneralDatasource>()))
    ];
  }
}
