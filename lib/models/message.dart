 class MessageModel {

  String idUser;
  String? message;
  String? urlImage;
  String type;

  MessageModel({
    required this.idUser,
    this.message,
    this.urlImage,
    required this.type
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUser': idUser,
      'message': message,
      'urlImage': urlImage,
      'type': type
    };

    return map;
  }
}