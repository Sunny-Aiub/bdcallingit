import 'package:bdcallingit/app/http/urls.dart';
import 'package:bdcallingit/app/modules/home/views/drawer_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        drawer: const DrawerView(),
        body: Obx(
          () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0,
                mainAxisExtent: 280 // spacing between columns
                ),
            padding: const EdgeInsets.all(8.0), // padding around the grid
            itemCount: _controller.allProducts.length, // total number of items
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.black)),
                child: buildProductItem(index),
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
          child: (_controller.allProducts[index].url != null)
              ? CachedNetworkImage(
                  placeholder: (context, url) => const Icon(
                    Icons.image,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: Urls.BASE_URL +
                      _controller.allProducts[index].url.toString(),
                )
              : const Icon(Icons.image),
        ),
        const SizedBox(height: 8),
        Text(
          _controller.allProducts[index].name.toString(),
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
              _controller.allProducts[index].price.toString(),
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
              _controller.allProducts[index].stockQuantity.toString(),
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
