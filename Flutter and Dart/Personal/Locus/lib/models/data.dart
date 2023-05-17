class Data {
  final String? id;
  final String? lat;
  final String? long;
  final String? address;
  final String? treeid;

  Data(
      {required this.id,
      required this.lat,
      required this.long,
      required this.address,
      required this.treeid});

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': lat,
        'longitude': long,
        'address': address,
        'treeid': treeid,
      };
  static Data fromJson(Map<String, dynamic> json) => Data(
      id: json['id'],
      lat: json['latitude'],
      long: json['longitude'],
      address: json['address'],
      treeid: json['treeid']);
}
