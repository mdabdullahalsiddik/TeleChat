import 'package:get/get.dart';
import 'package:telechat/app/data/models/users_model.dart';
import 'package:telechat/app/data/services/api_services.dart';
import 'package:telechat/app/data/services/shared_services.dart';
import 'package:telechat/app/routes/sing_in_routes.dart';

class HomeController extends GetxController {
  var users = <UsersModel>[].obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  void getUsers() async {
    try {
      isLoading.value = true;
      var response = await ApiServices.users();
      isLoading.value = false;
      if (response.statusCode == 200) {
        users.value = usersModelFromJson(response.body);
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
      isLoading.value = false;
    }
    update();
  }

  void logout() async {
    await SharedServices.removeData('token');
    Get.offAllNamed(SingInRoutes.singIn);

    update();
  }
}
