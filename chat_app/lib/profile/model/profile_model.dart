class User {
  const User({
    this.id,
    this.contact,
    this.name,
    this.photo,
  });

  final String? id;

  final String? contact;

  final String? name;

  final String? photo;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String?,
      contact: map['contact'] as String?,
      photo: map['photo'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'contact': contact,
      'photo': photo,
      'name': name,
    };
  }
}
