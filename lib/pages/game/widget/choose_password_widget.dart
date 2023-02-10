import 'package:flutter/material.dart';
import 'package:password_game/const.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/pages/game/widget/ball_widget.dart';
import 'package:password_game/usecases/game/set_password_usecase.dart';
import 'package:password_game/widgets/app_button.dart';

import '../../../widgets/app_text.dart';

class ChoosePasswordWidget extends StatefulWidget {
  final String playerName;
  final SetPasswordUsecase setPasswordUsecase;
  const ChoosePasswordWidget({Key? key, required this.playerName, required this.setPasswordUsecase}) : super(key: key);

  @override
  State<ChoosePasswordWidget> createState() => _ChoosePasswordWidgetState();
}

class _ChoosePasswordWidgetState extends State<ChoosePasswordWidget> {

  void _putSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      )
    );
  }

  void _setPassword() async {
    if (await widget.setPasswordUsecase.submit() == false) {
      _putSnack("Invalid password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(widget.playerName, bold: true, size: 40),
        Dimensions.sizeVer(3),
        const AppText("Escolha a senha para o USER2 adivinhar"),
        Dimensions.sizeVer(3),
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimensions.height(2)),
          width: Dimensions.width(35),
          color: AppColors.secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dimensions.sizeHor(2),
              for(int i = 0; i < 4; i++) ... [
                BallWidget(index: i, setPasswordUsecase: widget.setPasswordUsecase),
                Dimensions.sizeHor(2)
              ]
            ],
          ),
        ),
        Dimensions.sizeVer(3),
        AppButton(text: "Enviar", onTap: _setPassword),
      ],
    );
  }
}