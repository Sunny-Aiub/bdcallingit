import 'dart:convert';
import 'dart:io';

import 'package:bdcallingit/app/data/models/products_response.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../../../http/request.dart';
import '../../../http/urls.dart';
import '../../../utils/common_funcs.dart';
import '../../../utils/constants.dart';

class AddProductController extends GetxController {
  final nameController = TextEditingController();
  final nameControllerFocus = FocusNode();
  final descController = TextEditingController();
  final descControllerFocus = FocusNode();

  final quantityController = TextEditingController();
  final quantityControllerFocus = FocusNode();

  final priceController = TextEditingController();
  final priceControllerFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  GetStorage storage = GetStorage();
  RxBool isImageAvailable = false.obs;
  File? imageFile;
  Product? selectedProduct;
  @override
  void onInit() {
    selectedProduct = Get.arguments;
    update();
    print(selectedProduct?.name);

    if (selectedProduct != null) {
      nameController.text = selectedProduct!.name.toString();
      quantityController.text = selectedProduct!.stockQuantity.toString();
      priceController.text = selectedProduct!.price.toString();
    }
    super.onInit();
  }

  setFileData(File file) {
    if (file != null) {
      imageFile = file;
      isImageAvailable.value = true;
      update();
    } else {
      isImageAvailable.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void uploadProduct(
    String filePath,
  ) {
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        EasyLoading.show(status: 'Wait Please while processing...');

        // var uri = Uri.parse(Urls.GET_MY_PRODUCTS);
        // http.MultipartRequest request = http.MultipartRequest('POST', uri);
        // request.headers['Authorization'] =
        //     'Bearer ${GetStorage().read('token')}';
        // request.fields.addAll({
        //   'name': nameController.text,
        //   'price': priceController.text,
        //   'stock_quantity': quantityController.text,
        //   'description': descController.text
        // });
        // http.MultipartFile multipartFile =
        //     await http.MultipartFile.fromPath('image', filePath);
        // request.files.add(multipartFile);
        //
        // var response = await request.send().onError((error, stackTrace) {
        //   EasyLoading.dismiss();
        //   CommonFunctions.showToast(MessageConstant.serverError, Colors.red);
        //
        //   throw Exception();
        // });
        // EasyLoading.dismiss();
        //
        // if (response.statusCode == 200) {
        //   EasyLoading.dismiss();
        //
        //   var jsonData = await http.Response.fromStream(response);
        //   Map<String, dynamic> json = jsonDecode(jsonData.body);
        //
        //   if (jsonData.statusCode == 200) {
        //     CommonFunctions.showToast('Product Uploaded', Colors.green);
        //   }
        // } else if (response.statusCode == 401) {
        // } else {
        //   EasyLoading.dismiss();
        //   CommonFunctions.showToast(MessageConstant.commonError, Colors.red);
        // }
        var request = http.MultipartRequest(
            'POST', Uri.parse('${Urls.BASE_URL}/api/my-products'));
        request.headers['Authorization'] =
            'Bearer ${GetStorage().read('token')}';
        request.fields.addAll({
          'name': nameController.text,
          'price': priceController.text,
          'stock_quantity': quantityController.text,
          'description': descController.text
        });
        if (filePath != '') {
          request.files
              .add(await http.MultipartFile.fromPath('image', filePath));
        }

        http.StreamedResponse response = await request.send();
        var responsed = await http.Response.fromStream(response);

        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          final responseData = json.decode(responsed.body);
          print(responseData);
        } else {
          EasyLoading.dismiss();
          print(response.reasonPhrase);
        }
      } else {
        EasyLoading.dismiss();
        CommonFunctions.showToast(MessageConstant.networkError, Colors.red);
      }
    });
  }

  void editProduct(String filePath, String productId) {
    Connectivity().checkConnectivity().then((connection) async {
      if (connection == ConnectivityResult.mobile ||
          connection == ConnectivityResult.wifi) {
        EasyLoading.show(status: 'Wait Please while processing...');

        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                '${Urls.BASE_URL}/api/my-products/$productId?_method=PUT'));
        request.headers['Authorization'] =
            'Bearer ${GetStorage().read('token')}';
        request.fields.addAll({
          'name': nameController.text,
          'price': priceController.text,
          'stock_quantity': quantityController.text,
          'description': descController.text
        });
        if (filePath != '') {
          request.files
              .add(await http.MultipartFile.fromPath('image', filePath));
        }

        http.StreamedResponse response = await request.send();
        var responsed = await http.Response.fromStream(response);

        if (response.statusCode == 200) {
          final responseData = json.decode(responsed.body);
          print(responseData);
        } else {
          print(response.reasonPhrase);
        }
      } else {
        EasyLoading.dismiss();
        CommonFunctions.showToast(MessageConstant.networkError, Colors.red);
      }
    });
  }
}
