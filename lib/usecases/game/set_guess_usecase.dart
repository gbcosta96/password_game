import '../../data/player_repository.dart';
import '../../models/player_model.dart';

class SetGuessUsecase {
  final String roomId;
  final String playerName;

  SetGuessUsecase({required this.roomId, required this.playerName});

  final List<int> _guess = [-1, -1, -1, -1];

  void setGuess(int index, int value) {
    if (index < _guess.length && index >= 0) {
      _guess[index] = value;
    }
  }

  Future<bool> submit() async {
    if (_guess.contains(-1)) {
      return false;
    }
    PlayerRepository playerRepository = PlayerRepository(roomId);
    PlayerModel player = await playerRepository.getPlayer(playerName);
    player.guesses ??= [];
    player.guesses!.add(_guess);
    playerRepository.updatePlayer(player);
    return true;
  }
}