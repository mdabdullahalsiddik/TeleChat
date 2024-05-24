import 'package:get/get.dart';
import 'package:telechat/app/data/services/shared_services.dart';
import 'package:telechat/app/routes/home_routes.dart';
import 'package:telechat/app/routes/sing_in_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    timer();

    super.onInit();
  }

  checkToken() async {
    final token = await SharedServices.getData(SetType.string, 'token');

    // ignore: unnecessary_null_comparison
    if (token != null) {
      Get.offAllNamed(HomeRoutes.home);
    } else {
      Get.offAllNamed(SingInRoutes.singIn);
    }
  }

  void timer() async {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      checkToken();
    });
  }
}
