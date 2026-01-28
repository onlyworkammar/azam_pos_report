class SaleItem {
  final String id;
  final String categoryId;
  final String categoryName;
  final int quantity;
  final int returnedQuantity;
  final double price;
  final double subtotal;

  SaleItem({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.quantity,
    required this.returnedQuantity,
    required this.price,
    required this.subtotal,
  });

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      quantity: json['quantity'] as int,
      returnedQuantity: json['returned_quantity'] as int? ?? 0,
      price: (json['price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'category_name': categoryName,
      'quantity': quantity,
      'returned_quantity': returnedQuantity,
      'price': price,
      'subtotal': subtotal,
    };
  }
}
