import 'package:arquitetura_mvc/app/routes/app_routes.dart';
import 'package:arquitetura_mvc/app/views/home_page.dart';
import 'package:arquitetura_mvc/app/views/initial_page.dart';
import 'package:arquitetura_mvc/app/views/login_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.INITIAL, page: () => InitialPage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
  ];
}