import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:telechat/utils/static/all_colors.dart';
import 'package:telechat/utils/static/all_images.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AllColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AllImages.logo,
              width: 100,
            ),
            SizedBox(height: size.height * 0.01),
            LoadingAnimationWidget.staggeredDotsWave(
              color: AllColors.primaryColor,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
