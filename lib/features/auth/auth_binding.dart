import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import 'auth_controller.dart';

class AuthBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.put(AuthController(Get.find<AuthDatasource>()))];
  }
}
