class Suppliers {
  final String id;
  final String sup_name;
  final String sup_phone;
  final String sup_address;

  Suppliers({
    required this.id,
    required this.sup_name,
    required this.sup_phone,
    required this.sup_address,
  });
  factory Suppliers.fromJson(Map<String, dynamic> json) {
    return Suppliers(
      id: json['_id'],
      sup_name: json['sup_name'],
      sup_phone: json['sup_phone'],
      sup_address: json['sup_address'],
    );
  }
}
