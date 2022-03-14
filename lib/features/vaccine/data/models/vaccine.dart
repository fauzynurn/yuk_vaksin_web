class Vaccine {
  final int id;
  final String name;
  final int interval;

  Vaccine({required this.id, required this.name, required this.interval});

  factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
      id: json['vaccineId'], name: json['name'], interval: json['interval']);
}
