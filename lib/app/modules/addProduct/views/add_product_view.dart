import 'dart:io';
import 'dart:typed_data';

import 'package:bdcallingit/app/utils/common_funcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/products_response.dart';
import '../../../services/get_permissions.dart';
import '../../../utils/custom_button.dart';
import '../../../utils/custom_input_field.dart';
import '../../../utils/custom_validator.dart';
import '../controllers/add_product_controller.dart';
import 'package:path/path.dart' as path;

class AddProductView extends StatelessWidget {
  // final Product? selectedProduct;
  AddProductView({
    Key? key,
    // this.selectedProduct
  }) : super(key: key);
  final AddProductController _controller = Get.find<AddProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Obx(() {
          return Form(
            key: _controller.formKey,
            child: ListView(
              children: [
                (_controller.isImageAvailable.value == false)
                    ? CustomButton(
                        buttonTitle: 'Upload Photo',
                        // width: 160,
                        // height: 48,

                        margin: const EdgeInsets.all(0),
                        textAlign: TextAlign.center,
                        color: Colors.blueGrey,
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                        onPressed: () => onAddPhotoClicked(),
                      )
                    : InkWell(
                        onTap: () => onAddPhotoClicked(),
                        child: Center(
                            child: Image.file(
                          _controller.imageFile!,
                          height: Get.width,
                          width: Get.width,
                          fit: BoxFit.contain,
                        ))),
                const SizedBox(height: 16),

                ///name
                SearchWidget(
                  controller: _controller.nameController,
                  focusNode: _controller.nameControllerFocus,
                  validator: (value) => MyCustomValidator.validateEmptyField(
                      _controller.nameController.text, context),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  isEnabled: true,
                  hintText: 'name',
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 16),

                ///desc
                SearchWidget(
                  controller: _controller.descController,
                  focusNode: _controller.descControllerFocus,
                  // validator: (value) =>
                  //     MyCustomValidator.validateEmptyField(value, context)(
                  //         _controller.descController.text, context),
                  prefixIcon: const Icon(
                    Icons.description,
                    color: Colors.black,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  isEnabled: true,
                  hintText: 'description',
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 16),

                ///unit
                SearchWidget(
                  controller: _controller.priceController,
                  focusNode: _controller.priceControllerFocus,
                  keyboardType: TextInputType.number,
                  validator: (value) => MyCustomValidator.validateEmptyField(
                      _controller.priceController.text, context),
                  prefixIcon: const Icon(
                    Icons.price_change,
                    color: Colors.black,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  isEnabled: true,
                  hintText: 'price',
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 16),

                ///stock
                SearchWidget(
                  controller: _controller.quantityController,
                  focusNode: _controller.quantityControllerFocus,
                  keyboardType: TextInputType.number,
                  validator: (value) => MyCustomValidator.validateEmptyField(
                      _controller.quantityController.text, context),
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: Colors.black,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  isEnabled: true,
                  hintText: 'quantity',
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 32),
                (_controller.selectedProduct != null)
                    ? CustomButton(
                        buttonTitle: 'Update',
                        onPressed: () async {
                          if (_controller.formKey.currentState!.validate() ) {
                            _controller
                                .editProduct(_controller.imageFile?.path ?? '',_controller.selectedProduct!.id.toString());

                          }
                        },
                      )
                    : CustomButton(
                        buttonTitle: 'Continue',
                        onPressed: () async {
                          if (_controller.formKey.currentState!.validate()) {
                              _controller
                                  .uploadProduct(_controller.imageFile?.path ?? '');

                          }
                        },
                      )
              ],
            ),
          );
        }),
      ),
    );
  }

  onAddPhotoClicked() async {
    ///new code
    final bool cameraStatus = await GetPermissions.getCameraPermission();

    if (cameraStatus) {
      final result = await ImagePicker().pickImage(source: ImageSource.camera);

      if (result == null) {
        return;
      } else {
        File file = File(result.path);
        _controller.setFileData(file);
        Uint8List fileBytes = await file.readAsBytes();
        // uploadImage(path.basename(file.path), fileBytes, signature);
      }
    } else {
      CommonFunctions.showToast(
          'Camera permission is not Available', Colors.red);
    }
  }
}
