final class LatLong {
  double? latitude;
  double? longitude;

  LatLong({
    this.latitude,
    this.longitude,
  });

  factory LatLong.fromJson(Map<String, dynamic> json) {
    return LatLong(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  LatLong copyWith({
    double? latitude,
    double? longitude,
  }) {
    return LatLong(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
