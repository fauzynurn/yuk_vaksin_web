import 'package:get/get.dart';

import '../../data/datasources/auth_datasource.dart';
import 'reset_password_controller.dart';

class ResetPasswordBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put(
        ResetPasswordController(
          Get.find<AuthDatasource>(),
        ),
      )
    ];
  }
}
