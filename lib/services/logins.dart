import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl = 'https://dummyjson.com/auth/login';

  Future<dynamic> login(String username, String password) async {
    print("Username: $username, Password: $password");

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to login: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to login: $e");
    }
  }
}
