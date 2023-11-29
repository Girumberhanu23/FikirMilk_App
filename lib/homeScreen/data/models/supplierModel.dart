class Suppliers {
  final String id;
  final String sup_name;
  final String sup_phone;
  final String sup_address;
  final String tested_by;

  Suppliers({
    required this.id,
    required this.sup_name,
    required this.sup_phone,
    required this.sup_address,
    required this.tested_by,
  });
  factory Suppliers.fromJson(Map<String, dynamic> json) {
    return Suppliers(
      id: json['_id'],
      sup_name: json['name'],
      sup_phone: json['phone'],
      sup_address: json['address'],
      tested_by: json['tested_by'],
    );
  }
}
