import '../../data/player_repository.dart';
import '../../data/room_repository.dart';
import '../../models/player_model.dart';

enum JoinErr {
  kSuccess,
  kNameTaken,
  kRoomIsFull,
  kRoomDoesntExists,
}

class JoinRoomUsecase {
  Future<JoinErr> call(String roomId, String playerName) async {
    RoomRepository repository = RoomRepository();
    PlayerRepository playerRepository = PlayerRepository(roomId);

    bool hasRoom = await repository.checkRoom(roomId);
    if (!hasRoom) {
      return JoinErr.kRoomDoesntExists;
    }

    List<PlayerModel> players = await playerRepository.getPlayers();
    if (players.length >= 2) {
      return JoinErr.kRoomIsFull;
    }

    if (players.any((player) => player.name == playerName)) {
      return JoinErr.kNameTaken;
    }

    PlayerModel player = PlayerModel(name: playerName);
    playerRepository.addPlayer(player);
    return JoinErr.kSuccess;
  }
}