import 'dart:io';

class CreateSupplier {
  final String sup_name;
  final String sup_phone;
  final String sup_address;
  final String? tested_by;
  final String amount;
  final String price;
  final File picture;

  CreateSupplier(
      {required this.sup_name,
      required this.sup_phone,
      required this.sup_address,
      this.tested_by,
      required this.amount,
      required this.price,
      required this.picture});

  factory CreateSupplier.fromJson(Map<String, dynamic> json) {
    return CreateSupplier(
      sup_name: json['sup_name'] ?? '',
      sup_phone: json['sup_phone'] ?? '',
      sup_address: json['sup_address'] ?? '',
      tested_by: json['tested_by'] ?? '',
      amount: json['amount'] ?? '',
      price: json['price'] ?? '',
      picture: json['picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sup_name': sup_name,
      'sup_phone': sup_phone,
      'sup_address': sup_address,
      'tested_by': tested_by,
      'amount': amount,
      'price': price,
      'picture': picture,
    };
  }
}
