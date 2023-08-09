import 'dart:convert';
import 'package:impulse/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService._privateConstructor();
  static const _ip = "192.168.100.18";

  static final AuthService _instance = AuthService._privateConstructor();

  factory AuthService() {
    return _instance;
  }

  Future<Map<String, dynamic>> _sendRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 5));

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }

  Future<Map<String, dynamic>> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = User(
      id: '',
      name: name,
      email: email,
      password: password,
      address: '',
      type: '',
      token: '',
    );
    final response = await _sendRequest(
      'http://$_ip:3000/api/signup',
      user.toJson(),
    );

    return response;
  }

  Future<Map<String, dynamic>> signInUser({
    required String email,
    required String password,
  }) async {
    final response = await _sendRequest(
      'http://$_ip:3000/api/signin',
      {"email": email, "password": password},
    );

    if (response['status'] == 200) {
      final data = jsonDecode(response['body']);
      final userData = data['existingUser'];
      final user = User(
        id: userData['_id'],
        name: userData['name'],
        email: userData['email'],
        password: userData['password'],
        address: userData['address'],
        type: userData['type'],
        token: data['token'],
      );
      return {'status': response['status'], 'body': jsonEncode(user)};
    }
    return response;
  }

  Future<Map<String, dynamic>> updateUser({required User user}) async {
    final response = await _sendRequest(
      'http://$_ip:3000/api/updateUser',
      user.toJson(),
    );

    if (response['status'] == 200) {
      final data = jsonDecode(response['body']);
      final userData = data['user'];
      final user = User(
        id: userData['_id'],
        name: userData['name'],
        email: userData['email'],
        password: userData['password'],
        address: userData['address'],
        type: userData['type'],
        token: data['token'],
      );
      return {'status': response['status'], 'body': jsonEncode(user)};
    }
    return response;
  }
}
