import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/player_model.dart';

class PlayerRepository {
  final String roomId;
  late CollectionReference playersCollection;

  PlayerRepository(this.roomId) {
    playersCollection = FirebaseFirestore.instance.collection('rooms').doc(roomId).collection('players');
  }

  /* Get Players */
  Stream<List<PlayerModel>> getPlayersSnap(String id) {
    return playersCollection.snapshots().map((snap) => _playersFromSnap(snap.docs));
  }

  List<PlayerModel> _playersFromSnap(List<QueryDocumentSnapshot> snap) {
    final players = <PlayerModel>[];
    for(final player in snap) {
      players.add(PlayerModel.fromJson(player.data() as Map<String, dynamic>, player.reference.id));
    }
    return players;
  }

  Future<List<PlayerModel>> getPlayers() async {
    List<QueryDocumentSnapshot> playersSnapshot = 
      await playersCollection.get().then((value) => value.docs);
    return _playersFromSnap(playersSnapshot);
  }

  Future<PlayerModel> getPlayer(String name) async {
    DocumentSnapshot snap = await playersCollection.doc(name).get();
    return PlayerModel.fromSnapshot(snap);
  }

  Future<void> addPlayer(PlayerModel player) async {
    await playersCollection.doc(player.name)
      .set(player.toJson());
  }

  Future<void> removePlayer(PlayerModel player) async {
    await playersCollection.doc(player.refId).delete();
  }

  Future<void> updatePlayer(PlayerModel player) async {
    await playersCollection.doc(player.refId).update(player.toJson());
  }

}