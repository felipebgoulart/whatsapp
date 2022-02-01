class UserModel {

  String? name;
  String email;
  String password;

  UserModel({
    this.name,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'email': email
    };

    return map;
  }
}