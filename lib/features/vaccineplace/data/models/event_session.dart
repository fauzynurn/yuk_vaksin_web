class EventSession {
  int id;
  int session;
  String startTime;
  String endTime;

  EventSession(
      {required this.id,
      required this.session,
      required this.startTime,
      required this.endTime});

  factory EventSession.fromJson(Map<String, dynamic> json) => EventSession(
        id: json['id'],
        session: json['session'],
        startTime: json['startTime'],
        endTime: json['endTime'],
      );
}
