import 'package:arquitetura_mvc/app/routes/app_pages.dart';
import 'package:arquitetura_mvc/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main () {
  runApp(GetMaterialApp(
    title: "App MVC - Provérbio do dia",
    debugShowCheckedModeBanner: false,
    getPages: AppPages.routes,
    initialRoute: Routes.INITIAL,
  ));
}