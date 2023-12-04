
import 'package:bdcallingit/app/routes/app_pages.dart';
import 'package:bdcallingit/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DrawerView extends GetView {
  const DrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.7,
      height: Get.height,
      child: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Home'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onTap: () => Get.offAndToNamed(Routes.HOME),
              ),
              if (GetStorage().read(KeyConstant.isLoggedIn) == true)ListTile(
                title: const Text('My Products'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
                onTap: () => Get.offAndToNamed(Routes.MY_PRODUCTS),
              ),
              if (GetStorage().read(KeyConstant.isLoggedIn) == false)ListTile(
                title: const Text('Login'),
                textColor: Colors.white,
                trailing: const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
                onTap: () => Get.offAndToNamed(Routes.LOGIN),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
