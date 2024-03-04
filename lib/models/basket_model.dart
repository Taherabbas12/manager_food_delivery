class BasketModel {
  final String menuItemsClientId;
  final String clientId;
  final String price;
  final String dateTime;
  final String receivedDate;
  final String menuItemName;
  final String quantity;
  final String name;
  final String phone;
  final String email;

  // "menuitemsclientID": "13",
  //   "ClientID": "11",
  //   "Price": "150000",
  //   "DateTime": "2024-03-04",
  //   "received_date": "قيد الانتضار",
  //   "MenuItemName": "كباب شوي نفر",
  //   "quantity": "1",
  //   "name": "gfran1",
  //   "phone": "09998",
  //   "email": "gfran2"

  BasketModel({
    required this.menuItemsClientId,
    required this.clientId,
    required this.price,
    required this.dateTime,
    required this.receivedDate,
    required this.menuItemName,
    required this.quantity,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      menuItemsClientId: json['menuitemsclientID'],
      clientId: json['ClientID'],
      price: json['Price'],
      dateTime: json['DateTime'],
      receivedDate: json['received_date'],
      menuItemName: json['MenuItemName'],
      quantity: json['quantity'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
    );
  }
}
