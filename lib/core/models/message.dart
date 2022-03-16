 class MessageModel {

  String idUser;
  String? message;
  String? urlImage;
  String type;
  String? date;

  MessageModel({
    required this.idUser,
    this.message,
    this.urlImage,
    required this.type,
    this.date
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idUser': idUser,
      'message': message,
      'urlImage': urlImage,
      'type': type,
      'date': date
    };

    return map;
  }
}