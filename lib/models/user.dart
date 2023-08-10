import 'package:flutter/material.dart' show immutable;

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
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      type: json['type'] as String,
      token: json['token'] as String,
      profileUrl: json['profileUrl'] as String,
      downloadableProfileUrl: json['downloadableProfileUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'phone': phone,
      'type': type,
      'token': token,
      'profileUrl': profileUrl,
      'downloadableProfileUrl': downloadableProfileUrl,
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
