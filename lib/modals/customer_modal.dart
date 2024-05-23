import 'dart:convert';

CustomerModal chatUserModalFromJson(String str) =>
    CustomerModal.fromJson(json.decode(str));

String chatUserModalToJson(CustomerModal data) => json.encode(data.toJson());

class CustomerModal {
  String uId;
  String cEmail;
  List assignedDesigner;
  String cName;
  int nId;

  CustomerModal({
    required this.uId,
    required this.cEmail,
    required this.assignedDesigner,
    required this.cName,
    required this.nId,
  });

  factory CustomerModal.fromJson(Map<String, dynamic> json) => CustomerModal(
        uId: json["uId"] ?? '',
        cEmail: json["cEmail"] ?? '',
        assignedDesigner: json['assignedDesigner'] ?? [],
        cName: json['cName'] ?? '',
        nId: json['nId'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "uId": uId,
        "cEmail": cEmail,
        "assignedDesigner": assignedDesigner,
        "cName": cName,
        "nId": nId,
      };
}
