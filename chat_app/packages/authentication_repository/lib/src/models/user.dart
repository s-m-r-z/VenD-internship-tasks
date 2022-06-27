import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  final String? email;

  final String id;

  final String? name;

  final String? photo;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, String> map) {
    return User(
      id: map['id']!,
      name: map['name'],
    );
  }
  Map<String, String> toJson(String token) {
    return {'email': email!, 'id': id, 'name': name!, 'token': token};
  }

  @override
  List<Object?> get props => [email, id, name, photo];
}
