import 'dart:convert';

import 'package:bdcallingit/app/http/urls.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/products_response.dart';
import '../../../http/request.dart';
import '../../../utils/common_funcs.dart';
import '../../../utils/constants.dart';

class MyProductsController extends GetxController {

  RxList<Product> myProducts = <Product>[].obs;
  GetStorage storage = GetStorage();


  @override
  void onInit() {
    super.onInit();
    getMyProducts();
  }

  void getMyProducts() {
    EasyLoading.show(status: 'Loading...');
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        Request request = Request(url: Urls.GET_MY_PRODUCTS, header: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer ${storage.read(KeyConstant.accessToken)}',

        });

        var response = await request.get().onError((error, stackTrace) {
          EasyLoading.dismiss();
          CommonFunctions.showToast(MessageConstant.serverError, Colors.red);

          throw Exception();
        });
        EasyLoading.dismiss();
        print(response.body);
        if (response.statusCode == 200) {
          ProductsResponse productsResponse = ProductsResponse.fromJson(jsonDecode(response.body));
          myProducts.value = productsResponse.data;

        }  else {
          CommonFunctions.showToast(MessageConstant.commonError, Colors.red);
        }
      } else {}
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void deleteProduct(String id) {
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        Request request = Request(url: Urls.GET_MY_PRODUCTS + "/$id",  header: {
          "Authorization": 'Bearer ${storage.read(KeyConstant.accessToken)}',
        });

        var response = await request.delete().onError((error, stackTrace) {
          EasyLoading.dismiss();
          CommonFunctions.showToast(MessageConstant.serverError, Colors.red);

          throw Exception();
        });
        EasyLoading.dismiss();
        print(response.body);
        if (response.statusCode == 200) {
          CommonFunctions.showToast("Product Deleted", Colors.red);
          getMyProducts();

        } else {
          CommonFunctions.showToast(MessageConstant.commonError, Colors.red);
        }
      } else {}
    });

  }


}
