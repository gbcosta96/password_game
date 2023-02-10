import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/player_model.dart';
import '../models/room_model.dart';
import 'player_repository.dart';

class RoomRepository {
  final CollectionReference roomsCollection = FirebaseFirestore.instance.collection('rooms');

  /* Get Rooms */
  Stream<List<RoomModel>> getRoomsSnap() {
    return roomsCollection.snapshots().map((snap) => _roomsFromSnap(snap.docs));
  }

  List<RoomModel> _roomsFromSnap(List<QueryDocumentSnapshot> snap) {
    List<RoomModel> rooms = [];
    for(final room in snap) {
      rooms.add(RoomModel.fromSnapshot(room));
    }
    return rooms;
  }

  /* Get Room */
  Stream<RoomModel> getRoomSnap(String id) {
    return roomsCollection.doc(id).snapshots().map((snap) => RoomModel.fromSnapshot(snap));
  }

  Future<RoomModel> getRoom(String id) async {
    DocumentSnapshot snap = await roomsCollection.doc(id).get();
    return RoomModel.fromSnapshot(snap);
  }

  Future<bool> checkRoom(String id) {
    return roomsCollection.doc(id).get().then((value) => value.exists);
  }

  Future<void> addRoom(RoomModel room, PlayerModel host) async {
    await roomsCollection.doc(room.refId).set(room.toJson());
    await PlayerRepository(room.refId).addPlayer(host);
  }

  Future<void> removeRoom(String roomId) async {
    await roomsCollection.doc(roomId).delete();
  }

  Future<void> updateRoom(String roomId, RoomModel room) async {
    await roomsCollection.doc(roomId).update(room.toJson());
  }
}