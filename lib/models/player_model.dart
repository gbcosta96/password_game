import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerModel {
  final String name;
  List<int>? password;
  List<List<int>>? guesses;
  final String? refId;

  PlayerModel({required this.name, this.password, this.guesses, this.refId});

  factory PlayerModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PlayerModel.fromJson(data, snapshot.reference.id);
  }

  factory PlayerModel.fromJson(Map<String, dynamic> json, String refId) {
     return PlayerModel(
      name: json['name'],
      password: json['password'] != null ? List<int>.from(json['password']) : null,
      guesses: json['guesses'] != null ? List<List<int>>.from(json['guesses']) : null,
      refId: refId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'name': name,
      'password': password,
      'guesses': guesses,
    };
  }
}