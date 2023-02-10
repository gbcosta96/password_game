import '../../data/room_repository.dart';
import '../../models/player_model.dart';
import '../../models/room_model.dart';

class CreateRoomUsecase {
  Future<bool> call(String roomId, String playerName) async {
    RoomRepository repository = RoomRepository();
    await repository.checkRoom(roomId).then((value) {
      if(!value) {
        RoomModel newRoom = RoomModel(refId: roomId);
        PlayerModel host = PlayerModel(name: playerName);
        repository.addRoom(newRoom, host);
        return true;
      }
    });
    return false;
  }
}