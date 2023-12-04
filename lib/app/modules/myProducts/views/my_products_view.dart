import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../http/urls.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/drawer_view.dart';
import '../controllers/my_products_controller.dart';

class MyProductsView extends StatelessWidget {
  MyProductsView({Key? key}) : super(key: key);
  final MyProductsController _controller = Get.find<MyProductsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyProductsView'),
          centerTitle: true,
        ),
        drawer: const DrawerView(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.toNamed(Routes.ADD_PRODUCT);
          },
        ),
        body: Obx(
          () => ListView.builder(
            padding: const EdgeInsets.all(8.0), // padding around the grid
            itemCount: _controller.myProducts.length, // total number of items
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.black)),
                child: Stack(
                  children: [
                    buildProductItem(index),
                Positioned(
                            bottom: 1,
                            right: 1,
                            child: InkWell(
                              onTap: (){
                                _controller.deleteProduct(_controller.myProducts[index].id);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )),
                    Positioned(top: 1, right: 1, child:InkWell(
                      onTap: (){
                        Get.toNamed(Routes.ADD_PRODUCT,arguments: _controller.myProducts[index]);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.edit,
                        ),
                      ),
                    )),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget buildProductItem(int index) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: (_controller.myProducts[index].url != null)
              ? CachedNetworkImage(
                  placeholder: (context, url) => const Icon(
                    Icons.image,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: Urls.BASE_URL +
                      _controller.myProducts[index].url.toString(),
                )
              : const Icon(Icons.image),
        ),
        const SizedBox(height: 8),
        Text(
          _controller.myProducts[index].name.toString(),
          style: const TextStyle(
              fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Price:",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            Text(
              _controller.myProducts[index].price.toString(),
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Quantity:",
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            Text(
              _controller.myProducts[index].stockQuantity.toString(),
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
