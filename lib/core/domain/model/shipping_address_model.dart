class ShippingAddress {
  final int id;
  final String name;
  final String phone;
  final String address;
  final int postalCode;
  final bool defaultLocation;
  final String latitude;
  final String longitude;
  final Province province;
  final City city;
  final Subdistrict subdistrict;

  ShippingAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.defaultLocation,
    required this.latitude,
    required this.longitude,
    required this.province,
    required this.city,
    required this.subdistrict,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      postalCode: json['postal_code'],
      defaultLocation: json['default_location'],
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      province: Province.fromJson(json['province']),
      city: City.fromJson(json['city']),
      subdistrict: Subdistrict.fromJson(json['subdistrict']),
    );
  }
}

class Province {
  final int id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
    );
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Subdistrict {
  final int id;
  final String name;

  Subdistrict({required this.id, required this.name});

  factory Subdistrict.fromJson(Map<String, dynamic> json) {
    return Subdistrict(
      id: json['id'],
      name: json['name'],
    );
  }
}
