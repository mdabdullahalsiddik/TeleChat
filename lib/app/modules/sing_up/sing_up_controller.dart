import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
  var selectDate = DateTime.now().obs;
  RxBool isLoading = RxBool(false);

  galleryPickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);

      userModel.value.profileImage = selectedImage.value.path;
    }

    update();
  }

  setPasswordValidator() {
    passwordValidator.value = !passwordValidator.value;
  }

  singIn() {
    Get.toNamed(SingInRoutes.singIn);
  }

  chooseDate() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: selectDate.value,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (date != null && date != selectDate.value) {
      selectDate.value = date;

      userModel.value.dateOfBirth =
          selectDate.value.toString().substring(0, 10);
    }

    update();
  }

  register() async {
    if (forky.currentState!.validate()) {
      if (userModel.value.profileImage != null) {
        if (userModel.value.dateOfBirth != null) {
          if (userModel.value.password!.length >= 6) {
            try {
              isLoading.value = true;

              final response = await ApiServices.register(userModel.value);

              if (response.statusCode != 200) {
                Get.snackbar("Error", "Something went wrong");
                return;
              }
              final decoded = jsonDecode(await response.stream.bytesToString());

              await SharedServices.setData(
                  SetType.string, 'token', decoded['token']);
              isLoading.value = false;
              Get.offNamed(HomeRoutes.home);
              Get.snackbar("Success", "Registered successfully");
            } catch (e) {
              Get.snackbar("Error", e.toString());
              isLoading.value = false;
            }
          } else {
            Get.snackbar(
                "Error", "Password must be at least 6 characters or more");
          }
        } else {
          Get.snackbar("Error", "Please choose date of birth");
        }
      } else {
        Get.snackbar("Error", "Please choose profile image");
      }
    } else {
      Get.snackbar("Error", "Fill all the fields");
    }

    update();
  }
}
