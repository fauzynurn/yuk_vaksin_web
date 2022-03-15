import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/auth_page.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  final AuthDatasource authDatasource;

  EnsureAuthMiddleware(this.authDatasource);

  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // await Future.delayed(Duration(milliseconds: 500));
    var token = await authDatasource.getUserToken();
    if (token == null || token.isEmpty) {
      return RouteDecoder.fromRoute(AuthPage.routeName);
    }
    return await super.redirectDelegate(route);
  }
}
