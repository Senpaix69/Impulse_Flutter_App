import 'package:flutter/material.dart' show immutable;
import 'package:impulse/consts/models.dart';

@immutable
class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String type;
  final String token;
  final String profileUrl;
  final String downloadableProfileUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.address = "",
    this.phone = "",
    this.profileUrl = "",
    this.downloadableProfileUrl = "",
    this.type = "",
    this.token = "",
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[userIdColumn] as String,
      name: json[userNameColumn] as String,
      email: json[userEmailColumn] as String,
      password: json[userPasswordColumn] as String,
      address: json[userAddressColumn] as String,
      phone: json[userPhoneColumn] as String,
      type: json[userTypeColumn] as String,
      token: json[userTokenColumn] as String,
      profileUrl: json[userProfileUrlColumn] as String,
      downloadableProfileUrl: json[userDProfileUrlColumn] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      userIdColumn: id,
      userNameColumn: name,
      userEmailColumn: email,
      userPasswordColumn: password,
      userAddressColumn: address,
      userPhoneColumn: phone,
      userTypeColumn: type,
      userTokenColumn: token,
      userProfileUrlColumn: profileUrl,
      userDProfileUrlColumn: downloadableProfileUrl,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? phone,
    String? type,
    String? token,
    String? profileUrl,
    String? downloadableProfileUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      token: token ?? this.token,
      profileUrl: profileUrl ?? this.profileUrl,
      downloadableProfileUrl:
          downloadableProfileUrl ?? this.downloadableProfileUrl,
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name, email: $email, password: $password, address: $address, type: $type, token: $token, profileUrl: $profileUrl, downloadableProfileUrl: $downloadableProfileUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          address == other.address &&
          type == other.type &&
          token == other.token &&
          profileUrl == other.profileUrl &&
          downloadableProfileUrl == other.downloadableProfileUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      address.hashCode ^
      type.hashCode ^
      token.hashCode ^
      profileUrl.hashCode ^
      downloadableProfileUrl.hashCode;
}
