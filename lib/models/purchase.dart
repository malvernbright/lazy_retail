class Purchase {
  final int? id;
  final String itemName;
  final String? description;
  final double quantity;
  final String unit;
  final double buyingPrice;
  final double totalCost;
  final String datePurchased;

  const Purchase({
    this.id,
    required this.itemName,
    this.description,
    required this.quantity,
    required this.unit,
    required this.buyingPrice,
    required this.totalCost,
    required this.datePurchased,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
        id: json['id'],
        itemName: json['item_name'],
        description: json['description'],
        quantity: json['quantity'],
        unit: json['unit'],
        buyingPrice: json['buying_price'],
        totalCost: json['total_cost'],
        datePurchased: json['date_purchased']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_name': itemName,
      'quantity': quantity,
      'unit': unit,
      'buying_price': buyingPrice,
      'total_cost': totalCost,
      'date_purchased': datePurchased,
    };
  }

  @override
  String toString() {
    return """id: $id,
    item_name: $itemName,
    quantity: $quantity,
    'unit: $unit,
    buying_price: $buyingPrice,
    total_cost: $totalCost,
    date_purchased: $datePurchased""";
  }
}
