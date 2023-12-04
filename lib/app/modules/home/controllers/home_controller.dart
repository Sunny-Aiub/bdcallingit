import 'dart:convert';

import 'package:bdcallingit/app/data/models/products_response.dart';
import 'package:bdcallingit/app/http/request.dart';
import 'package:bdcallingit/app/http/urls.dart';
import 'package:bdcallingit/app/utils/common_funcs.dart';
import 'package:bdcallingit/app/utils/constants.dart';
import 'package:bdcallingit/app/utils/user_pref.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../utils/api_status.dart';

class HomeController extends GetxController {
  UserPref userPref = UserPref();
  RxList<Product> allProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }



  void getAllProducts() {
    EasyLoading.show(status: 'Loading...');
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        Request request = Request(url: Urls.GET_ALL_PRODUCTS, header: {
          'Content-Type': 'application/json',
        });

        var response = await request.get().onError((error, stackTrace) {
          EasyLoading.dismiss();
          CommonFunctions.showToast(MessageConstant.serverError, Colors.red);

          throw Exception();
        });
        EasyLoading.dismiss();
        print(response.body);
        if (response.statusCode == 200) {
          ProductsResponse productsResponse =
              ProductsResponse.fromJson(jsonDecode(response.body));
              allProducts.value = productsResponse.data;

        }  else {
          CommonFunctions.showToast(MessageConstant.commonError, Colors.red);
        }
      } else {}
    });
  }
}
