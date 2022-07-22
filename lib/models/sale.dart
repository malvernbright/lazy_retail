class Sale {
  final int? id;
  final String itemName;
  final double quantity;
  final double totalSale;
  final DateTime dateSold;

  const Sale({
    this.id,
    required this.itemName,
    required this.quantity,
    required this.totalSale,
    required this.dateSold,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
        id: json['id'],
        itemName: json['item_name'],
        quantity: json['quantity'],
        totalSale: json['total_cost'],
        dateSold: json['date_purchased']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_name': itemName,
      'quantity': quantity,
      'total_cost': totalSale,
      'date_purchased': dateSold,
    };
  }

  @override
  String toString() {
    return """id: $id,
    item_name: $itemName,
    quantity: $quantity,
    total_cost: $totalSale,
    date_purchased: $dateSold""";
  }
}
