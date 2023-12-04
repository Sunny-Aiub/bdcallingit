import 'dart:convert';

import 'package:bdcallingit/app/data/models/login_response.dart';
import 'package:bdcallingit/app/routes/app_pages.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../http/request.dart';
import '../../../http/urls.dart';
import '../../../utils/common_funcs.dart';
import '../../../utils/constants.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final emailControllerFocus = FocusNode();
  final passwordController = TextEditingController();
  final passwordControllerFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
   // checkIfLoggedIn();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void apiSignIn() {
    EasyLoading.show(status: 'Loading...');
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        Request request = Request(url: Urls.LOGIN_URL, body: {
          'username': emailController.text.toString().trim(),
          'password': passwordController.text.toString(),
          "grant_type": "password",
          "client_id": "2",
          "client_secret": "Cr1S2ba8TocMkgzyzx93X66szW6TAPc1qUCDgcQo",
        }, header: {
          'Content-Type': 'application/json',
        });

        var response = await request.post().onError((error, stackTrace) {
          EasyLoading.dismiss();
          CommonFunctions.showToast(MessageConstant.serverError, Colors.red);

          throw Exception();
        });
        EasyLoading.dismiss();
        print(response.body);
        if (response.statusCode == 200) {
          LoginResponse model =
              LoginResponse.fromJson(jsonDecode(response.body));
          storage.write(KeyConstant.accessToken, model.accessToken);
          storage.write(KeyConstant.isLoggedIn, true);
          Get.offAndToNamed(Routes.MY_PRODUCTS);
        } else {
          CommonFunctions.showToast(MessageConstant.commonError, Colors.red);
        }
      } else {}
    });
  }

  void checkIfLoggedIn() {
    if (GetStorage().read(KeyConstant.isLoggedIn) == true) {
      Get.offAndToNamed(Routes.MY_PRODUCTS);
    } else {
    }
  }
}
