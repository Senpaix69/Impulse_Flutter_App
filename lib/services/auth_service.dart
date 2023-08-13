import 'dart:convert' show jsonEncode;
import 'package:impulse/consts/env.dart';
import 'package:impulse/consts/service_contants.dart';
import 'package:impulse/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() => _instance;

  Future<Map<String, dynamic>> _sendRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$horokuAddr$url'),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 10));

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signUpUser({
    required String name,
    required String email,
    required String password,
    int method = 0, // 0 -> email-password
    String phone = "",
    String downloadableProfileUrl = "",
  }) async {
    final user = User(
      id: '',
      name: name,
      email: email,
      password: password,
      phone: phone,
      downloadableProfileUrl: downloadableProfileUrl,
    );

    return _sendRequest(
      signUp,
      {'user': user.toJson(), 'method': method},
    );
  }

  Future<Map<String, dynamic>> signInUser({
    required String email,
    required String password,
  }) async {
    return _sendRequest(
      signIn,
      {"email": email, "password": password},
    );
  }

  Future<Map<String, dynamic>> updateUser({required User user}) async {
    return _sendRequest(updUser, user.toJson());
  }
}
