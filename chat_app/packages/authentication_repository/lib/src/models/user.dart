import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.token,
  });

  final String? email;

  final String id;

  final String? name;

  final String? photo;

  final String? token;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String?,
      token: map['token'] as String?,
      email: map['email'] as String?,
    );
  }
  Map<String, dynamic> toJson(String fcmToken, String name) {
    return <String, dynamic>{
      'email': email,
      'id': id,
      'name': name,
      'token': fcmToken,
    };
  }

  @override
  List<Object?> get props => [email, id, name, photo];
}
