import 'package:bdcallingit/app/data/models/products_response.dart';
import 'package:get/get.dart';

import '../modules/addProduct/bindings/add_product_binding.dart';
import '../modules/addProduct/views/add_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myProducts/bindings/my_products_binding.dart';
import '../modules/myProducts/views/my_products_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MY_PRODUCTS,
      page: () => MyProductsView(),
      binding: MyProductsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () =>  AddProductView(),
      binding: AddProductBinding(),
    ),
  ];
}
