class CountryModel {

  String name;
  String code;
  String? mask;

  CountryModel({
    required this.name,
    required this.code,
    this.mask
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      mask: json['mask'] ?? ''
    );
  }
}