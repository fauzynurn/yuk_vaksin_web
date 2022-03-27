import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

import 'email_validation_controller.dart';

class EmailValidationBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put(
        EmailValidationController(
          Bind.find<AuthDatasource>(),
        ),
      )
    ];
  }
}
