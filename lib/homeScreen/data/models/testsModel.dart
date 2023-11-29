class Tests {
  final String cob;
  final String organo_leptic;
  final String gerber;
  Tests({
    required this.cob,
    required this.organo_leptic,
    required this.gerber,
  });

  factory Tests.fromJson(Map<String, dynamic> json) => Tests(
      cob: json["cob"],
      organo_leptic: json["organo_leptic"],
      gerber: json["gerber"]);
}
