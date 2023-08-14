import 'package:flutter/material.dart' show immutable;

@immutable
class Item {
  final String id;
  final String title;
  final String image;
  final String categoryId;
  final String itemId;
  final String subCatId;
  final double rating;
  final double price;

  const Item({
    required this.id,
    required this.title,
    required this.image,
    required this.categoryId,
    required this.itemId,
    required this.subCatId,
    this.rating = 0.0,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      categoryId: json['categoryId'],
      itemId: json['itemId'],
      subCatId: json['subCatId'],
      rating: json['rating'] ?? 0.0,
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'categoryId': categoryId,
      'itemId': itemId,
      'subCatId': subCatId,
      'rating': rating,
      'price': price,
    };
  }

  Item copyWith({
    String? id,
    String? title,
    String? image,
    String? categoryId,
    String? itemId,
    String? subCatId,
    double? rating,
    double? price,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      itemId: itemId ?? this.itemId,
      subCatId: subCatId ?? this.subCatId,
      rating: rating ?? this.rating,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, title: $title, image: $image, categoryId: $categoryId, itemId: $itemId, subCatId: $subCatId, rating: $rating, price: $price)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          image == other.image &&
          categoryId == other.categoryId &&
          itemId == other.itemId &&
          subCatId == other.subCatId &&
          rating == other.rating &&
          price == other.price;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      image.hashCode ^
      categoryId.hashCode ^
      itemId.hashCode ^
      subCatId.hashCode ^
      rating.hashCode ^
      price.hashCode;
}
