import 'dart:convert' show jsonDecode;
import 'package:impulse/consts/env.dart';
import 'package:http/http.dart' as http;
import 'package:impulse/consts/service_contants.dart';
import 'package:impulse/models/item.dart';
import 'package:impulse/models/item_details.dart';

class ItemService {
  ItemService._privateConstructor();

  static final ItemService _instance = ItemService._privateConstructor();

  factory ItemService() => _instance;

  Future<Map<String, dynamic>> _sendRequest(
    String url,
    String queryParams,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$ip$url$queryParams'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ).timeout(const Duration(seconds: 10));

      return {'status': response.statusCode, 'body': response.body};
    } catch (e) {
      return {'status': -1, 'body': e.toString()};
    }
  }

  Future<List<Item>> getAllItems({required String categoryId}) async {
    final response = await _sendRequest(allItems, "/$categoryId");
    final data = jsonDecode(response['body']);

    if (data is List) {
      final itemList = data.map((json) => Item.fromJson(json)).toList();
      return itemList;
    } else {
      return [];
    }
  }

  Future<ItemDetail> getItemDetail({required String itemId}) async {
    try {
      final response = await _sendRequest(getItemDetails, "/$itemId");
      final data = jsonDecode(response['body']);
      return ItemDetail.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
