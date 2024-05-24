import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:telechat/app/data/models/user_models.dart';
import 'package:telechat/app/data/services/api_services.dart';
import 'package:telechat/app/data/services/shared_services.dart';
import 'package:telechat/app/routes/home_routes.dart';
import 'package:telechat/app/routes/sing_up_routes.dart';

class SingInController extends GetxController {
  RxBool isSecured = RxBool(true);
  var userModel = UserModel().obs;
  RxBool isLoading = RxBool(false);

  var forky = GlobalKey<FormState>();
  var passwordValidator = true.obs;

  setPasswordValidator() {
    passwordValidator.value = !passwordValidator.value;
  }

  singUp() {
    Get.toNamed(SingUpRoutes.singUp);
  }

  login() async {
    if (forky.currentState!.validate()) {
      if (userModel.value.password!.length >= 6) {
        try {
          isLoading.value = true;

          var response = await ApiServices.login(userModel.value);

          final decode = jsonDecode(response.body);
          if (response.statusCode != 200) {
            Get.snackbar("Error", "${decode['message']}");
          } else {
            await SharedServices.setData(
                SetType.string, 'token', decode['token']);

            isLoading.value = false;

            Get.offAllNamed(HomeRoutes.home);
            Get.snackbar("Success", "Login successfully");
          }
        } catch (e) {
          Get.snackbar("Error", "$e");
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Error", "Password must be at least 6 characters or more");
      }
    } else {
      Get.snackbar("Error", "Please fill all fields");
    }

    update();
  }
}
