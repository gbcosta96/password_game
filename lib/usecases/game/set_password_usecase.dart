import '../../data/player_repository.dart';
import '../../models/player_model.dart';

class SetPasswordUsecase {
  final String roomId;
  final String playerName;

  SetPasswordUsecase({required this.roomId, required this.playerName});

  final List<int> _password = [-1, -1, -1, -1];

  void setPassword(int index, int value) {
    if (index < _password.length && index >= 0) {
      _password[index] = value;
    }
  }

  Future<bool> submit() async {
    if (_password.contains(-1)) {
      return false;
    }
    PlayerRepository playerRepository = PlayerRepository(roomId);
    PlayerModel player = await playerRepository.getPlayer(playerName);
    player.password = _password;
    playerRepository.updatePlayer(player);
    return true;
  }
}