import 'dart:convert';

CustomerModal chatUserModalFromJson(String str) =>
    CustomerModal.fromJson(json.decode(str));

String chatUserModalToJson(CustomerModal data) => json.encode(data.toJson());

class CustomerModal {
  String id;
  String email;
  List assignedDesigner;

  CustomerModal(
      {required this.id, required this.email, required this.assignedDesigner});

  factory CustomerModal.fromJson(Map<String, dynamic> json) => CustomerModal(
      id: json["id"],
      email: json["email"],
      assignedDesigner: json['assignedDesigner']);

  Map<String, dynamic> toJson() =>
      {"id": id, "email": email, "assignedDesinger": assignedDesigner};
}
