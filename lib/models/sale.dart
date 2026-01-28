import 'sale_item.dart';

class Sale {
  final String id;
  final String orderNumber;
  final double totalAmount;
  final DateTime readyTime;
  final List<SaleItem> items;
  final DateTime createdAt;
  final String createdBy;

  Sale({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.readyTime,
    required this.items,
    required this.createdAt,
    required this.createdBy,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'] as String,
      orderNumber: json['order_number'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      readyTime: DateTime.parse(json['ready_time'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => SaleItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'total_amount': totalAmount,
      'ready_time': readyTime.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
    };
  }
}
