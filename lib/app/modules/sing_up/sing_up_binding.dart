import 'package:get/get.dart';

import 'sing_up_controller.dart';

class SingUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingUpController>(
      () => SingUpController(),
    );
  }
}
