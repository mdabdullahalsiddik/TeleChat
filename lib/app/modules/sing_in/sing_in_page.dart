import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:telechat/utils/static/all_colors.dart';
import 'package:telechat/utils/static/all_images.dart';
import 'package:telechat/app/core/widgets/custom_bottom.dart';
import 'package:telechat/app/core/widgets/custom_text_field.dart';

import 'sing_in_controller.dart';

class SingInPage extends GetView<SingInController> {
  const SingInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  AllImages.logo,
                  width: 70,
                ),
                Text(
                  "Sing In",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Please enter your  email and password to continue your account",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AllColors.blackColor,
                      ),
                ),
              ],
            ),
            const Gap(20),
            Form(
              key: controller.forky,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextFromField(
                    onChanged: (p0) {
                      controller.userModel.value.email = p0;
                    },
                    hintText: "Enter your email address",
                    labelText: "Email Address",
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "User ID or Email can't be empty";
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  Obx(() => CustomTextFromField(
                        onChanged: (p0) {
                          controller.userModel.value.password = p0;
                        },
                        hintText: "Enter your password",
                        labelText: "Password",
                        obscureText: controller.passwordValidator.value,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          onPressed: () => controller.setPasswordValidator(),
                          icon: Icon(
                            controller.passwordValidator.value == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AllColors.blackColor,
                          ),
                        ),
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Password can't be empty";
                          }
                          return null;
                        },
                      )),
                  const Gap(10),
                  Obx(
                    () => CustomButton(
                      text: controller.isLoading.value ? "Loading...." : "Login",
                      onTap: () => controller.login(),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap(5),
                InkWell(
                  onTap: () => controller.singUp(),
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
