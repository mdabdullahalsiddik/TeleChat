import 'package:http/http.dart' as http;
import 'package:telechat/app/core/helpers/token_helpers.dart';
import 'package:telechat/app/data/models/user_models.dart';
import 'package:telechat/utils/api_config/endpoints.dart';

class ApiServices {
  static Future<http.StreamedResponse> register(UserModel userModel) async {
    final request = http.MultipartRequest('POST', ApiEndpoints.register);
    request.fields.addAll({
      'name': userModel.name!,
      'email': userModel.email!,
      'phone': userModel.phone!,
      'password': userModel.password!,
      'date_of_birth': userModel.dateOfBirth!,
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_image',
        userModel.profileImage!,
      ),
    );
    request.headers.addAll(
      {
        "Accept": "application/json",
      },
    );

    final response = await request.send();
    return response;
  }

  static Future<http.Response> login(UserModel userModel) async {
    return await http.post(
      ApiEndpoints.login,
      headers: {
        "Accept": "application/json",
      },
      body: userModel.toLogin(),
    );
  }

  static Future<http.Response> users() async {
    return await http.get(
      ApiEndpoints.users,
      headers: {
        "Accept": "application/json",
        "Authorization": await authToken(),
      },
    );
  }
}
