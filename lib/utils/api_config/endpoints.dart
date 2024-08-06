import 'package:telechat/utils/api_config/api.dart';

class ApiEndpoints {
  static String apiUrl = '${BaseApiUrl.baseUrl}/api';
  static Uri register = Uri.parse('$apiUrl/register');
  static Uri login = Uri.parse('$apiUrl/login');
  static Uri users = Uri.parse('$apiUrl/users');
  static String messages = '$apiUrl/messages';

  static Uri sendMessages = Uri.parse('$apiUrl/send-message');
}
