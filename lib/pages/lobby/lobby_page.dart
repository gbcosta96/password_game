import 'package:flutter/material.dart';
import 'package:password_game/data/room_repository.dart';
import 'package:password_game/pages/game/game_page.dart';
import 'package:password_game/pages/lobby/widget/room_widget.dart';

import '../../const.dart';
import '../../dimensions.dart';
import '../../models/room_model.dart';
import '../../usecases/lobby/create_room_usecase.dart';
import '../../usecases/lobby/join_room_usecase.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input.dart';
import '../../widgets/app_text.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerRoom = TextEditingController();
  List<RoomModel> _rooms = [];

  @override
  void initState() {
    super.initState();
    RoomRepository().getRoomsSnap().listen((snap) {
      setState(() {
        _rooms = snap.where((element) => element.hidden == false).toList();
      });
    });
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerRoom.dispose();
    super.dispose();
  }

  void _putSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      )
    );
  }

  bool _checkFields() {
    if(controllerName.text.isEmpty) {
      _putSnack("Name is empty");
    } else if(controllerRoom.text.isEmpty) {
      _putSnack("Room is empty");
    } else {
      return true;
    }
    return false;
  }

  void _joinRoom() {
    if (_checkFields()) {
      JoinRoomUsecase().call(controllerRoom.text, controllerName.text).then((value) {
        switch(value) {
          case JoinErr.kNameTaken:
            _putSnack("Name taken!");
            break;
          case JoinErr.kRoomIsFull:
            _putSnack("Room is full!");
            break;
          case JoinErr.kRoomDoesntExists:
            _putSnack("Room doesn't exists!");
            break;
          case JoinErr.kSuccess:
            Navigator.pushReplacement(
              context, MaterialPageRoute(
                builder: (context) => GamePage(
                  roomId: controllerRoom.text, playerName: controllerName.text
                )
              )
            );
            break;
        }
      });
    }
  }

  void _createRoom() {
    if (_checkFields()) {
      CreateRoomUsecase().call(controllerRoom.text, controllerName.text).then((value) {
        if (!value) {
          _putSnack("Room already exists!");
        } else {
          Navigator.pushReplacement(
            context, MaterialPageRoute(
              builder: (context) => GamePage(
                roomId: controllerRoom.text, playerName: controllerName.text
              )
            )
          );
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(Dimensions.smallest(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Dimensions.sizeVer(10),
                const AppText("Senha", size: 40),
                Dimensions.sizeVer(5),
                AppInput(controller: controllerName, prefixIcon: Icons.person, hintText: "Usuário"),
                Dimensions.sizeVer(3),
                AppInput(controller: controllerRoom, prefixIcon: Icons.person, hintText: "Sala"),
                Dimensions.sizeVer(3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      text: "Criar",
                      onTap: _createRoom,
                    ),
                    Dimensions.sizeHor(5),
                    AppButton(
                      text: "Entrar",
                      onTap: _joinRoom,
                    ),
                  ],
                ),
                Dimensions.sizeVer(5),
                SizedBox(
                  width: Dimensions.width(100),
                  child: Column(
                    children: [
                      const AppText("Salas"),
                      Dimensions.sizeVer(5),
                      SizedBox(
                        height: Dimensions.height(35),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemCount: _rooms.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return RoomWidget(roomId: _rooms[index].refId);
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}