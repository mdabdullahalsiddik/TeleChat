import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:telechat/utils/static/all_colors.dart';
import 'package:telechat/utils/static/all_images.dart';
import 'package:telechat/app/core/widgets/custom_bottom.dart';
import 'package:telechat/app/core/widgets/custom_text_field.dart';
import 'package:telechat/app/modules/sing_up/sing_up_controller.dart';

class SingUpPage extends GetView<SingUpController> {
  const SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: AllColors.blackColor,
          ),
        ),
        title: Row(children: [
          Image.asset(
            AllImages.logo,
            width: 35,
          ),
          const Gap(5),
          Text(
            "Sing Up",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AllColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ]),
      ),
      body: GetBuilder<SingUpController>(
        init: SingUpController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(50),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      controller.selectedImage.value.path == ""
                          ? CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  AllColors.primaryColor.withOpacity(0.5),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: AllColors.primaryColor,
                              backgroundImage:
                                  FileImage(controller.selectedImage.value),
                            ),
                      Container(
                          decoration: BoxDecoration(
                            color: AllColors.whiteColor,
                          ),
                          child: InkWell(
                            onTap: () async {
                              await controller.galleryPickImage();
                            },
                            child: const Icon(
                              Icons.add_a_photo,
                            ),
                          )),
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
                            controller.userModel.value.name = p0;
                          },
                          hintText: "Enter your full name",
                          labelText: "Full Name",
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Full name can't be empty";
                            }
                            return null;
                          },
                        ),
                        const Gap(10),
                        CustomTextFromField(
                          onChanged: (p0) {
                            controller.userModel.value.phone = p0;
                          },
                          hintText: "Enter your phone number",
                          labelText: "Phone Number",
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Phone Number can't be empty";
                            }
                            return null;
                          },
                        ),
                        const Gap(10),
                        CustomTextFromField(
                          onChanged: (p0) {
                            controller.userModel.value.email = p0;
                          },
                          hintText: "Enter your email address",
                          labelText: "Email Address",
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Email can't be empty";
                            }
                            return null;
                          },
                        ),
                        const Gap(10),
                        Obx(
                          () => Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AllColors.blackColor,
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListTile(
                              onTap: () async {
                                controller.chooseDate();
                              },
                              leading: const Icon(
                                Icons.calendar_month,
                              ),
                              title: Text(
                                controller.userModel.value.dateOfBirth ??
                                    "Select Date",
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Obx(() => CustomTextFromField(
                              onChanged: (p0) {
                                controller.userModel.value.password = p0;
                              },
                              hintText: "Enter your password",
                              labelText: "Password",
                              obscureText: controller.passwordValidator.value,
                              textInputAction: TextInputAction.done,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.setPasswordValidator(),
                                icon: Icon(
                                  // ignore: unrelated_type_equality_checks
                                  controller.passwordValidator == true
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
                        const Gap(5),
                        Obx(
                          () => CustomButton(
                            text: controller.isLoading.value
                                ? "Loading..."
                                : "Register",
                            onTap: () => controller.register(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Gap(5),
                      InkWell(
                        onTap: () => controller.singIn(),
                        child: Text(
                          "Login",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
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
        },
      ),
    );
  }
}
