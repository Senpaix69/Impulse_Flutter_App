import 'package:flutter/foundation.dart' show immutable;
import 'package:impulse/consts/models.dart';

@immutable
class SubCategory {
  final String id;
  final String title;

  const SubCategory({
    required this.id,
    required this.title,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json[categoryIdColumn] as String,
      title: json[categoryTitleColumn] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      categoryIdColumn: id,
      categoryTitleColumn: title,
    };
  }

  SubCategory copyWith({
    String? id,
    String? title,
  }) {
    return SubCategory(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  String toString() {
    return 'SubCategory(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
