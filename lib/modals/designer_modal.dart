class DesignerModal {
  String uId;
  int nId;
  String cEmail;
  List<String> assignedCustomers;
  String cName;

  DesignerModal({
    required this.uId,
    required this.nId,
    required this.cEmail,
    required this.assignedCustomers,
    required this.cName,
  });

  factory DesignerModal.fromJson(Map<String, dynamic> json) => DesignerModal(
        uId: json["uId"] ?? '',
        nId: json["nId"] ?? '',
        cEmail: json["cEmail"] ?? '',
        assignedCustomers:
            (json['assignedCustomers'] as List<dynamic>?)?.cast<String>() ?? [],
        cName: json["cName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uId": uId,
        "nId": nId,
        "cEmail": cEmail,
        "assignedCustomers": assignedCustomers,
        "cName": cName,
      };
}
