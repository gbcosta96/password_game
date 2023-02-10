import 'package:flutter/material.dart';

import '../../const.dart';
import '../../dimensions.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText("Senha", size: 40),
              Dimensions.sizeVer(10),
              AppInput(controller: controllerName, prefixIcon: Icons.person, hintText: "Usuário"),
              Dimensions.sizeVer(10),
              AppInput(controller: controllerRoom, prefixIcon: Icons.person, hintText: "Sala",),
              Dimensions.sizeVer(10),
              AppButton(
                text: "Criar",
                onTap: () {
                  if (_checkFields()) {
                    CreateRoomUsecase().call(controllerRoom.text, controllerName.text);
                  }
                }
              ),
              AppButton(
                text: "Entrar",
                onTap: () {
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
                          _putSnack("Success!");
                          break;
                      }
                    });
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}