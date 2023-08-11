import 'dart:convert';
import 'package:impulse/consts/env.dart';
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

  Map<String, dynamic> parseUserResponse(Map<String, dynamic> response) {
    final data = jsonDecode(response['body']);
    final userData = data['newUser'];
    final user = User(
      id: userData['_id'],
      name: userData['name'],
      email: userData['email'],
      password: userData['password'],
      address: userData['address'],
      downloadableProfileUrl: userData['downloadableProfileUrl'],
      profileUrl: userData['profileUrl'],
      phone: userData['phoneNo'],
      type: userData['type'],
      token: data['token'],
    );
    return {'status': response['status'], 'body': jsonEncode(user)};
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

    final response = await _sendRequest(
      '/api/signup',
      {'user': user.toJson(), 'method': method},
    );

    return response['status'] == 200 ? parseUserResponse(response) : response;
  }

  Future<Map<String, dynamic>> signInUser({
    required String email,
    required String password,
  }) async {
    final response = await _sendRequest(
      '/api/signin',
      {"email": email, "password": password},
    );

    return response['status'] == 200 ? parseUserResponse(response) : response;
  }

  Future<Map<String, dynamic>> updateUser({required User user}) async {
    final response = await _sendRequest(
      '/api/updateUser',
      user.toJson(),
    );

    return response['status'] == 200 ? parseUserResponse(response) : response;
  }
}
