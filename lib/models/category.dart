import 'package:flutter/foundation.dart' show immutable, listEquals;
import 'package:impulse/consts/models.dart';
import 'package:impulse/models/sub_category.dart';

@immutable
class Category {
  final String id;
  final String imageUrl;
  final String title;
  final List<SubCategory> subcategories;

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
        subcategories = (json[categorySubCatColumn] as List)
            .map((subCatJson) => SubCategory.fromJson(subCatJson))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      categoryIdColumn: id,
      categoryImageColumn: imageUrl,
      categoryTitleColumn: title,
      categorySubCatColumn:
          subcategories.map((subCat) => subCat.toJson()).toList(),
    };
  }

  Category copyWith({
    String? id,
    String? imageUrl,
    String? title,
    List<SubCategory>? subcategories,
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
