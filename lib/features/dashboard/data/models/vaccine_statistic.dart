class VaccineStatistic {
  final int positive;
  final int recovered;
  final int dead;

  VaccineStatistic(
      {required this.positive, required this.recovered, required this.dead});

  factory VaccineStatistic.fromJson(Map<String, dynamic> json) =>
      VaccineStatistic(
          positive: json['confirmed']['value'],
          recovered: json['recovered']['value'],
          dead: json['deaths']['value']);
}
