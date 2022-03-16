import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/auth/auth_page.dart';
import 'package:yuk_vaksin_web/features/auth/data/datasources/auth_datasource.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  final authDatasource = Get.find<AuthDatasource>();

  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    // you can do whatever you want here
    // but it's preferable to make this method fast
    // await Future.delayed(Duration(milliseconds: 500));
    var token = await authDatasource.getUserToken();
    if (token == null || token.isEmpty) {
      debugPrint('not authenticated! go to login');
      return RouteDecoder.fromRoute(AuthPage.routeName);
    }
    debugPrint('authenticated! go to dashboard');
    return await super.redirectDelegate(route);
  }
}
