import 'package:bdcallingit/app/utils/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import 'package:get/get.dart';

import '../../../utils/custom_button.dart';
import '../../../utils/custom_validator.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
   LoginView({Key? key}) : super(key: key);
  final LoginController _signInController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key:_signInController.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SearchWidget(
                  controller: _signInController.emailController,
                  focusNode: _signInController.emailControllerFocus,
                  validator: (value) =>
                      MyCustomValidator.validateEmail(
                          _signInController.emailController.text, context),
                  prefixIcon: const Icon(
                    PhosphorIcons.envelope,
                    color: Colors.black,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  isEnabled: true,
                  hintText: 'email/username',
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 16),

                SearchWidget(
                  controller: _signInController.passwordController,
                  focusNode: _signInController.passwordControllerFocus,
                  validator: (value) =>
                      MyCustomValidator.validateEmptyField(
                          _signInController.passwordController.text, context),
                  prefixIcon: const Icon(
                    PhosphorIcons.password,
                    color: Colors.black,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  isEnabled: true,
                  hintText: 'password',
                  obscureText: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(4.0)),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  buttonTitle: 'Continue',
                  onPressed: () {
                    if (_signInController.formKey.currentState!.validate()) {
                      _signInController.apiSignIn();
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
