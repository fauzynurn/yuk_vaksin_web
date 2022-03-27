import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';
import 'package:yuk_vaksin_web/features/auth/forgotpassword/validation/code/view/code_validation_controller.dart';

class CodeValidationBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put(
        CodeValidationController(
          Bind.find<AuthDatasource>(),
        ),
      )
    ];
  }
}
