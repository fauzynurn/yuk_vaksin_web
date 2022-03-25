class VaccineStatistic {
  final int positive;
  final int recovered;
  final int dead;

  VaccineStatistic(
      {required this.positive, required this.recovered, required this.dead});

  factory VaccineStatistic.fromJson(Map<String, dynamic> json) =>
      VaccineStatistic(
        positive: json['update']['total']['jumlah_positif'],
        recovered: json['update']['total']['jumlah_sembuh'],
        dead: json['update']['total']['jumlah_meninggal'],
      );
}
