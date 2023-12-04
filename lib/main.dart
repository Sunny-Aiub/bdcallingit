import 'dart:io';

import 'package:bdcallingit/app/modules/home/bindings/home_binding.dart';
import 'package:bdcallingit/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  final getData = GetStorage();
  getData.writeIfNull(KeyConstant.isLoggedIn, false);

  HttpOverrides.global = MyHttpOverrides();
  runApp(
    GetMaterialApp(
      title: "BD CALLING IT",
      debugShowCheckedModeBanner: false,
      initialRoute: (GetStorage().read(KeyConstant.isLoggedIn) == true)
          ? Routes.MY_PRODUCTS
          : AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
