class EventSession {
  int id;
  int session;
  String vaccineName;
  int remainingQuota;
  String startTime;
  String endTime;
  int? vaccineType;

  EventSession(
      {required this.id,
      required this.session,
      required this.vaccineName,
      required this.remainingQuota,
      required this.startTime,
      required this.vaccineType,
      required this.endTime});

  factory EventSession.fromJson(Map<String, dynamic> json) => EventSession(
        id: json['id'],
        vaccineType: json['vaccineType'],
        session: json['session'],
        vaccineName: json['vaccineName'],
        remainingQuota: json['quota'],
        startTime: json['startTime'],
        endTime: json['endTime'],
      );
}
