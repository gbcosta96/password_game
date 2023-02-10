import 'package:flutter/material.dart';
import 'package:password_game/const.dart';
import 'package:password_game/data/player_repository.dart';
import 'package:password_game/data/room_repository.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/pages/game/widget/choose_password_widget.dart';
import 'package:password_game/usecases/game/set_password_usecase.dart';
import 'package:password_game/widgets/app_text.dart';

import '../../models/player_model.dart';
import '../../models/room_model.dart';

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

  @override
  void initState() {
    super.initState();
    setState(() {
      _setPasswordUsecase = SetPasswordUsecase(roomId: widget.roomId, playerName: widget.playerName);
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

  PlayerModel myself() {
    return _players!.firstWhere((element) => element.name == widget.playerName);
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
                  child: _room == null || _players == null || _setPasswordUsecase == null ?
                      const CircularProgressIndicator() :
                      myself().password == null ?
                          ChoosePasswordWidget(
                            playerName: widget.playerName,
                            setPasswordUsecase: _setPasswordUsecase!,
                          ) : 
                          const SizedBox(),                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}