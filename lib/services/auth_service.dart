import 'dart:convert' show jsonEncode;
import 'package:impulse/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      final response = await http.post(
        Uri.parse('http://192.168.100.18:3000/api/signup'),
        body: jsonEncode(user.toJson()),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(
        const Duration(seconds: 3),
      );

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.18:3000/api/signin'),
        body: jsonEncode({"email": email, "password": password}),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(
        const Duration(seconds: 3),
      );

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }
}
