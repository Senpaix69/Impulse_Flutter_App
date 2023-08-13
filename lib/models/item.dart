import 'package:flutter/foundation.dart' show listEquals, immutable;
import 'package:impulse/consts/models.dart';

@immutable
class Item {
  final String id;
  final String categoryId;
  final String title;
  final List<String> images;
  final double rating;
  final int price;
  final String productType;
  final List<String> colors;
  final int availableQuantity;
  final String description;
  final String videoUrl;
  final String privacyPolicy;

  const Item({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.images,
    this.rating = 0,
    required this.price,
    required this.productType,
    this.colors = const [],
    required this.availableQuantity,
    required this.description,
    this.videoUrl = '',
    required this.privacyPolicy,
  });

  Item copyWith({
    String? title,
    List<String>? images,
    double? rating,
    int? price,
    String? productType,
    List<String>? colors,
    int? availableQuantity,
    String? description,
    String? videoUrl,
    String? privacyPolicy,
  }) {
    return Item(
      id: id,
      categoryId: categoryId,
      title: title ?? this.title,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      productType: productType ?? this.productType,
      colors: colors ?? this.colors,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      itemIdColumn: id,
      itemCategoryIdColumn: categoryId,
      itemTitleColumn: title,
      itemImagesColumn: images,
      itemRatingColumn: rating,
      itemPriceColumn: price,
      itemProductTypeColumn: productType,
      itemColorsColumn: colors,
      itemAvailableQuantityColumn: availableQuantity,
      itemDescriptionColumn: description,
      itemVideoUrlColumn: videoUrl,
      itemPrivacyPolicyColumn: privacyPolicy,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json[itemIdColumn],
      categoryId: json[categoryIdColumn],
      title: json[itemTitleColumn],
      images: List<String>.from(json[itemImagesColumn]),
      rating: json[itemRatingColumn],
      price: json[itemPriceColumn],
      productType: json[itemProductTypeColumn],
      colors: List<String>.from(json[itemColorsColumn]),
      availableQuantity: json[itemAvailableQuantityColumn],
      description: json[itemDescriptionColumn],
      videoUrl: json[itemVideoUrlColumn],
      privacyPolicy: json[itemPrivacyPolicyColumn],
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, categoryId: $categoryId, title: $title, images: $images, rating: $rating, price: $price, '
        'productType: $productType, colors: $colors, '
        'availableQuantity: $availableQuantity, description: $description, '
        'videoUrl: $videoUrl, privacyPolicy: $privacyPolicy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Item &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.title == title &&
        listEquals(other.images, images) &&
        other.rating == rating &&
        other.price == price &&
        other.productType == productType &&
        listEquals(other.colors, colors) &&
        other.availableQuantity == availableQuantity &&
        other.description == description &&
        other.videoUrl == videoUrl &&
        other.privacyPolicy == privacyPolicy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryId.hashCode ^
        title.hashCode ^
        images.hashCode ^
        rating.hashCode ^
        price.hashCode ^
        productType.hashCode ^
        colors.hashCode ^
        availableQuantity.hashCode ^
        description.hashCode ^
        videoUrl.hashCode ^
        privacyPolicy.hashCode;
  }
}
