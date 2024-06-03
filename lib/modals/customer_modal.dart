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
  String phNo;
  String customerType;
  String pushToken;

  CustomerModal(
      {required this.uId,
      required this.phNo,
      required this.cEmail,
      required this.assignedDesigner,
      required this.cName,
      required this.nId,
      required this.customerType,
      required this.pushToken});

  factory CustomerModal.fromJson(Map<String, dynamic> json) => CustomerModal(
      phNo: json["phNo"] ?? '',
      uId: json["uId"] ?? '',
      cEmail: json["cEmail"] ?? '',
      assignedDesigner: json['assignedDesigner'] ?? [],
      cName: json['cName'] ?? '',
      nId: json['nId'] ?? 0,
      customerType: json['customerType'] ?? '',
      pushToken: json['pushToken'] ?? '');

  Map<String, dynamic> toJson() => {
        "phNo": phNo,
        "uId": uId,
        "cEmail": cEmail,
        "assignedDesigner": assignedDesigner,
        "cName": cName,
        "nId": nId,
        "customerType": customerType,
        "pushToken": pushToken
      };
}
