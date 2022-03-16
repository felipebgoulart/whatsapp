class UserModel {

  String? id;
  String? name;
  String email;
  String? password;
  String? imageUrl;

  UserModel({
    this.id,
    this.name,
    required this.email,
    this.password,
    this.imageUrl
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl
    };

    return map;
  }
}