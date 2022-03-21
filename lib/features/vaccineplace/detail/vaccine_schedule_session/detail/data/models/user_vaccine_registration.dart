enum OrderStatus { cancelled, done, ordered, unknown }

class UserVaccineRegistration {
  final int userId;
  final String orderNumber;
  final int vaccineType;
  final int orderId;
  final String username;
  final String statusLabel;

  OrderStatus get status {
    switch (statusLabel) {
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'done':
        return OrderStatus.done;
      case 'ordered':
        return OrderStatus.ordered;
      default:
        return OrderStatus.unknown;
    }
  }

  UserVaccineRegistration(
      {required this.userId,
      required this.orderNumber,
      required this.vaccineType,
      required this.orderId,
      required this.username,
      required this.statusLabel});

  factory UserVaccineRegistration.fromJson(Map<String, dynamic> json) =>
      UserVaccineRegistration(
          userId: json['userId'],
          orderNumber: json['orderNo'],
          vaccineType: json['vaccineType'],
          orderId: json['orderId'],
          username: json['userName'],
          statusLabel: json['orderStatus']);
}
