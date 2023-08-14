import 'dart:convert' show jsonDecode;
import 'package:impulse/consts/env.dart';
import 'package:http/http.dart' as http;
import 'package:impulse/consts/service_contants.dart';
import 'package:impulse/models/category.dart';
import 'package:impulse/models/sub_category.dart';

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
        Uri.parse('$myAPI$url$queryParams'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 10));

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final response = await _sendRequest(allCategories, "");
      if (response['status'] == 200) {
        final parsedCategories = parseCategories(response['body']);
        return parsedCategories;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<SubCategory>> getSubCategories({required String id}) async {
    try {
      final response = await _sendRequest(getCategory, "/$id");
      if (response['status'] == 200) {
        final data = jsonDecode(response['body']);
        final subcategories = (data['category']['subcategories'] as List)
            .map((subCatJson) => SubCategory.fromJson(subCatJson))
            .toList();
        return subcategories;
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Category> parseCategories(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  }
}
