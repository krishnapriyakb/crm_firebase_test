import 'dart:convert';

userModal chatUserModalFromJson(String str) =>
    userModal.fromJson(json.decode(str));

String chatUserModalToJson(userModal data) => json.encode(data.toJson());

class userModal {
  String id;

  String email;

  userModal({
    required this.id,
    required this.email,
  });

  factory userModal.fromJson(Map<String, dynamic> json) => userModal(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}
