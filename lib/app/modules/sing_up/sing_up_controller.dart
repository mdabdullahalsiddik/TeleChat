import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telechat/app/data/services/api_services.dart';
import 'package:telechat/app/data/models/user_models.dart';
import 'package:telechat/app/data/services/shared_services.dart';
import 'package:telechat/app/routes/home_routes.dart';
import 'package:telechat/app/routes/sing_in_routes.dart';

class SingUpController extends GetxController {
  RxBool isSecured = RxBool(true);
  var forky = GlobalKey<FormState>();
  var passwordValidator = true.obs;
  var selectedImage = File("").obs;
  String? images;

  var userModel = UserModel().obs;
  RxBool isLoading = RxBool(false);

  cameraPickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
      update();
      userModel.value.profileImage = selectedImage.value.path;
    }
  }

  galleryPickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
      update();
      userModel.value.profileImage = selectedImage.value.path;
    }
  }

  setPasswordValidator() {
    passwordValidator.value = !passwordValidator.value;
  }

  singIn() {
    Get.toNamed(SingInRoutes.singIn);
  }

  register() async {
    if (forky.currentState!.validate()) {
      if (userModel.value.password!.length >= 6) {
        try {
          isLoading.value = true;

          final response = await ApiServices.register(userModel.value);
          isLoading.value = false;

          if (response.statusCode != 200) {
            Get.snackbar("Error", "Something went wrong");
            return;
          }
          final decoded = jsonDecode(await response.stream.bytesToString());

          await SharedServices.setData(
              SetType.string, 'token', decoded['token']);
          Get.offNamed(HomeRoutes.home);
          Get.snackbar("Success", "Registered successfully");
        } catch (e) {
          Get.snackbar("Error", e.toString());
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Error", "Password must be at least 6 characters or more");
      }
    } else {
      Get.snackbar("Error", "Fill all the fields");
    }

    update();
  }
}
