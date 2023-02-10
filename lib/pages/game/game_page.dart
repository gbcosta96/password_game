import 'package:flutter/material.dart';
import 'package:password_game/const.dart';
import 'package:password_game/data/player_repository.dart';
import 'package:password_game/data/room_repository.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/pages/game/widget/game_widget.dart';
import 'package:password_game/usecases/game/set_guess_usecase.dart';
import 'package:password_game/usecases/game/set_password_usecase.dart';
import 'package:password_game/widgets/app_text.dart';

import '../../models/player_model.dart';
import '../../models/room_model.dart';
import 'widget/password_widget.dart';

class GamePage extends StatefulWidget {
  final String roomId;
  final String playerName;

  const GamePage({Key? key, required this.roomId, required this.playerName}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  RoomModel? _room;
  List<PlayerModel>? _players;
  SetPasswordUsecase? _setPasswordUsecase;
  SetGuessUsecase? _setGuessUsecase;

  @override
  void initState() {
    super.initState();
    setState(() {
      _setPasswordUsecase = SetPasswordUsecase(roomId: widget.roomId, playerName: widget.playerName);
      _setGuessUsecase = SetGuessUsecase(roomId: widget.roomId, playerName: widget.playerName);
    });

    RoomRepository().getRoomSnap(widget.roomId).listen((event) {
      setState(() {
        _room = event;
      });
    });
    PlayerRepository(widget.roomId).getPlayersSnap(widget.roomId).listen((event) {
      setState(() {
        _players = event;
      });
    });
  }

  PlayerModel _myself() {
    return _players!.firstWhere((element) => element.name == widget.playerName);
  }

  PlayerModel _enemy() {
    return _players!.firstWhere((element) => element.name != widget.playerName);
  }

  Widget _gameScreen() {
    if (_room == null || _players == null || _setPasswordUsecase == null || _setGuessUsecase == null) {
      return const CircularProgressIndicator();
    } else if (_players!.length <= 1) {
      return Column(
        children: const [
          AppText("Aguarde um adversário..."),
          CircularProgressIndicator(),
        ],
      );
    } else if (_myself().password == null) {
      return Column(
        children: [
          AppText(widget.playerName, bold: true, size: 40),
          Dimensions.sizeVer(3),
          AppText("Escolha a senha para ${_enemy().name} adivinhar"),
          Dimensions.sizeVer(3),
          PasswordWidget(
            setPasswordUsecase: _setPasswordUsecase!,
          ),
        ],
      );
    } else if (_enemy().password == null) {
      return Column(
        children: const [
          AppText("Aguarde o adversário..."),
          CircularProgressIndicator(),
        ],
      );
    } else {
      return GameWidget(myself: _myself(), enemy: _enemy(), setGuessUsecase: _setGuessUsecase!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Dimensions.sizeVer(5),
              const AppText("Senha", size: 40, bold: true,),
              Dimensions.sizeVer(20),
              Container(
                child: Center(
                  child: _gameScreen(),                
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}