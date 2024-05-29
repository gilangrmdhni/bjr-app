class StoreProfileRepository {
  final int id;
  final int userId;
  final String name;
  final String nickname;
  final String description;
  final String image;
  final int provinceId;
  final int cityId;
  final int subdistrictId;
  final String postalCode;
  final String address;
  final String latitude;
  final String longitude;
  final bool isOpen;

  StoreProfileRepository({
    required this.id,
    required this.userId,
    required this.name,
    required this.nickname,
    required this.description,
    required this.image,
    required this.provinceId,
    required this.cityId,
    required this.subdistrictId,
    required this.postalCode,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isOpen,
  });

  factory StoreProfileRepository.fromJson(Map<String, dynamic> json) {
    return StoreProfileRepository(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      nickname: json['nickname'],
      description: json['description'],
      image: json['image'],
      provinceId: json['province_id'],
      cityId: json['city_id'],
      subdistrictId: json['subdistrict_id'],
      postalCode: json['postal_code'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isOpen: json['is_open'],
    );
  }
}
