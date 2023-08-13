import 'dart:convert' show jsonDecode;
import 'package:impulse/consts/env.dart';
import 'package:http/http.dart' as http;
import 'package:impulse/consts/service_contants.dart';
import 'package:impulse/models/category.dart';

class ExploreService {
  ExploreService._privateConstructor();
  static final ExploreService _instance = ExploreService._privateConstructor();
  factory ExploreService() => _instance;

  Future<Map<String, dynamic>> _sendRequest(
    String url,
    String queryParams,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$horokuAddr$url$queryParams'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 10));

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }

  Future<List<Category>> getAllCategories() async {
    final response = await _sendRequest(allCategories, "");
    if (response['status'] == 200) {
      final parsedCategories = parseCategories(response['body']);
      return parsedCategories;
    } else {
      throw Exception("Failed to fetch categories");
    }
  }

  Future<List<String>> getSubCategories({required String id}) async {
    final response = await _sendRequest(getCategory, "/$id");
    if (response['status'] == 200) {
      final data = jsonDecode(response['body']);
      final subcategories = data['category']['subcategories'];
      return List<String>.from(subcategories);
    }
    throw Exception("Failed to fetch subcategories");
  }

  List<Category> parseCategories(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }
}
