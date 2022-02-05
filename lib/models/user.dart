class UserModel {

  String? name;
  String email;
  String? password;
  String? imageUrl;

  UserModel({
    this.name,
    required this.email,
    this.password,
    this.imageUrl
  });

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