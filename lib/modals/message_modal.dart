import 'dart:convert';

// Functions to parse and serialize the MessageModal object
MessageModal messageModalFromJson(String str) =>
    MessageModal.fromJson(json.decode(str));

String messageModalToJson(MessageModal data) => json.encode(data.toJson());

class MessageModal {
  String toId;
  String dlvryTime;
  String frId;
  String message;
  MessageType type;
  CustomWidgets customWidgets;

  MessageModal({
    required this.toId,
    required this.dlvryTime,
    required this.frId,
    required this.message,
    required this.type,
    required this.customWidgets,
  });

  // Factory constructor to create a MessageModal from JSON
  factory MessageModal.fromJson(Map<String, dynamic> json) => MessageModal(
        toId: json["toId"] ?? '',
        dlvryTime: json["dlvryTime"] ?? '',
        frId: json["frId"] ?? '',
        message: json["message"] ?? '',
        type: MessageTypeExtension.fromString(json["type"]),
        customWidgets: CustomWidgets.fromJson(json["customWidgets"] ?? {}),
      );

  // Method to convert the MessageModal to JSON
  Map<String, dynamic> toJson() => {
        "toId": toId,
        "dlvryTime": dlvryTime,
        "frId": frId,
        "message": message,
        "type": type.name,
        "customWidgets": customWidgets.toJson(),
      };
}

// Enum for the message type
enum MessageType { image, text, video, widget }

// Extension on the MessageType enum for string conversion
extension MessageTypeExtension on MessageType {
  static MessageType fromString(String? type) {
    switch (type) {
      case 'video':
        return MessageType.video;
      case 'image':
        return MessageType.image;
      case 'widget':
        return MessageType.widget;
      default:
        return MessageType.text;
    }
  }

  String get name {
    switch (this) {
      case MessageType.video:
        return 'video';
      case MessageType.image:
        return 'image';
      case MessageType.widget:
        return 'widget';
      default:
        return 'text';
    }
  }
}

// Class to represent custom widgets
class CustomWidgets {
  List<String> imageUrls;
  List<String> bodyText;
  List<String> audioUrls;
  int confirmationStatus;
  String confirmationType;

  CustomWidgets({
    required this.imageUrls,
    required this.bodyText,
    required this.audioUrls,
    required this.confirmationStatus,
    required this.confirmationType,
  });

  // Factory constructor to create CustomWidgets from JSON
  factory CustomWidgets.fromJson(Map<String, dynamic> json) => CustomWidgets(
        imageUrls: List<String>.from(json["imageUrls"] ?? []),
        bodyText: List<String>.from(json["bodyText"] ?? []),
        audioUrls: List<String>.from(json["audioUrls"] ?? []),
        confirmationStatus: json["confirmationStatus"] ?? 0,
        confirmationType: json["confirmationType"] ?? 'material',
      );

  // Method to convert CustomWidgets to JSON
  Map<String, dynamic> toJson() => {
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "bodyText": List<dynamic>.from(bodyText.map((x) => x)),
        "audioUrls": List<dynamic>.from(audioUrls.map((x) => x)),
        "confirmationStatus": confirmationStatus,
        "confirmationType": confirmationType,
      };
}
