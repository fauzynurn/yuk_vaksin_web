class DashboardStatistic {
  final int totalVaccinePlace;
  final int totalOrder;
  final int totalCancelledOrder;
  final int totalFinishedOrder;
  final int totalOngoingOrder;

  DashboardStatistic(
      {required this.totalVaccinePlace,
      required this.totalOrder,
      required this.totalCancelledOrder,
      required this.totalFinishedOrder,
      required this.totalOngoingOrder});

  factory DashboardStatistic.fromJson(Map<String, dynamic> json) =>
      DashboardStatistic(
          totalVaccinePlace: json['vaccinePlaceCount'],
          totalOrder: json['orderCount'],
          totalCancelledOrder: json['cancelledOrderCount'],
          totalFinishedOrder: json['finishedOrderCount'],
          totalOngoingOrder: json['ongoingOrderCount']);
}
