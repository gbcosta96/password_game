import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final int currentUsers;
  final String refId;

  RoomModel({
    required this.refId,
    this.currentUsers = 1,
  });

  factory RoomModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return RoomModel.fromJson(data, snapshot.reference.id);
  }

  factory RoomModel.fromJson(Map<String, dynamic> json, String refId) {
     return RoomModel(
      currentUsers: json['currentUsers'],
      refId: refId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'currentUsers': currentUsers,
    };
  }

}