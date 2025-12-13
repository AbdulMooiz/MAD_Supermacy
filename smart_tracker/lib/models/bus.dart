class Bus {
  final String id;
  final String name;
  final String? route;
  final double latitude;
  final double longitude;
  final double speed;
  final bool isActive;
  final DateTime lastUpdated;

  Bus({
    required this.id,
    required this.name,
    this.route,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.isActive,
    required this.lastUpdated,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      route: json['route'],
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      speed: (json['speed'] ?? 0).toDouble(),
      isActive: json['isActive'] ?? false,
      lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? '') ?? DateTime.now(),
    );
  }
}