import 'dart:convert';

DesignerModal chatUserModalFromJson(String str) =>
    DesignerModal.fromJson(json.decode(str));

String chatUserModalToJson(DesignerModal data) => json.encode(
      data.toJson(),
    );

class DesignerModal {
  String id;

  String email;
  List<String> assignedCustomers;
  String accId;

  DesignerModal(
      {required this.id,
      required this.email,
      required this.assignedCustomers,
      required this.accId});

  factory DesignerModal.fromJson(Map<String, dynamic> json) => DesignerModal(
      id: json["id"],
      email: json["email"],
      assignedCustomers:
          (json['assignedCustomers'] as List<dynamic>).cast<String>(),
      accId: json["accId"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "assignedCustomers": assignedCustomers,
        "accId": accId
      };
}
