import 'package:get/get.dart';

import '../../auth/data/datasources/auth_datasource.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(Get.find<AuthDatasource>()));
  }
}
