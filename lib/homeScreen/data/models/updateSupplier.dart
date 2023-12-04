class UpdateSupplier {
  final String sup_phone;
  final Tests tests;

  UpdateSupplier({
    required this.sup_phone,
    required this.tests,
  });

  factory UpdateSupplier.fromJson(Map<String, dynamic> json) {
    return UpdateSupplier(
      sup_phone: json['sup_phone'] ?? '',
      tests: Tests.fromJson(json['tests'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sup_phone': sup_phone,
      'tests': tests.toJson(), // Converting Tests object to JSON
    };
  }
}

class Tests {
  final String cob;
  final String organo_leptic;
  final String gerber;

  Tests({
    required this.cob,
    required this.organo_leptic,
    required this.gerber,
  });

  factory Tests.fromJson(Map<String, dynamic> json) {
    return Tests(
      cob: json["cob"] ?? '',
      organo_leptic: json["organo_leptic"] ?? '',
      gerber: json["gerber"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cob': cob,
      'organo_leptic': organo_leptic,
      'gerber': gerber,
    };
  }
}
