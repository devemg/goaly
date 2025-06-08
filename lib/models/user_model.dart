class User {
  String name;
  String email;
  String avatar;

  User({required this.name, required this.email, required this.avatar});
  
   User copyWith({
    String? name,
    String? email,
    String? avatar,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }
}