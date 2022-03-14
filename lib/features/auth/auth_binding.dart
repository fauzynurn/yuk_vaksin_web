import 'package:get/get.dart';

import 'auth_controller.dart';

class AuthBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.put(AuthController())];
  }
}
