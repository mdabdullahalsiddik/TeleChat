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
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: Row(children: [
            Image.asset(
              AllImages.logo,
              width: 30,
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          controller.selectedImage.value.path == ""
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      AllColors.primaryColor.withOpacity(0.5),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AllColors.primaryColor,
                                  backgroundImage:
                                      FileImage(controller.selectedImage.value),
                                ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showDialog(context);
                              },
                              icon: const Icon(Icons.edit),
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
                            CustomTextFromField(
                              onChanged: (p0) {
                                controller.userModel.value.dateOfBirth = p0;
                              },
                              hintText: "Enter your date of birth",
                              labelText: "Date of Birth",
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Email can't be empty";
                                }
                                return null;
                              },
                            ),
                            const Gap(10),
                            Obx(() => CustomTextFromField(
                                  onChanged: (p0) {
                                    controller.userModel.value.password = p0;
                                  },
                                  hintText: "Enter your password",
                                  labelText: "Password",
                                  obscureText:
                                      controller.passwordValidator.value,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              );
            }));
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Select Image"),
          children: [
            InkWell(
                onTap: () {
                  controller.cameraPickImage();
                  Navigator.pop(context);
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                  ),
                  title: Text("Camera"),
                )),
            InkWell(
              onTap: () async {
                await controller.galleryPickImage();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const ListTile(
                leading: Icon(
                  Icons.image,
                ),
                title: Text("Gallery"),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SocialLoginButton {}
