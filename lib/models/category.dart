import 'package:flutter/foundation.dart' show listEquals, immutable;
import 'package:impulse/consts/models.dart';

@immutable
class Category {
  final String id;
  final String imageUrl;
  final String title;
  final List<String> subcategories;

  const Category({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.subcategories = const [],
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json[categoryIdColumn] as String,
        imageUrl = json[categoryImageColumn] as String,
        title = json[categoryTitleColumn] as String,
        subcategories = List<String>.from(json[categorySubCatColumn]);

  Map<String, dynamic> toJson() {
    return {
      categoryIdColumn: id,
      categoryImageColumn: imageUrl,
      categoryTitleColumn: title,
      categorySubCatColumn: subcategories,
    };
  }

  Category copyWith({
    String? id,
    String? imageUrl,
    String? title,
    List<String>? subcategories,
  }) {
    return Category(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subcategories: subcategories ?? this.subcategories,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, imageUrl: $imageUrl, title: $title, subcategories: $subcategories)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          listEquals(subcategories, other.subcategories);

  @override
  int get hashCode =>
      id.hashCode ^ imageUrl.hashCode ^ title.hashCode ^ subcategories.hashCode;
}
