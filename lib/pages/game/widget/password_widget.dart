import 'package:flutter/material.dart';
import 'package:password_game/const.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/pages/game/widget/ball_widget.dart';
import 'package:password_game/usecases/game/set_password_usecase.dart';
import 'package:password_game/widgets/app_button.dart';

import '../../../usecases/game/set_guess_usecase.dart';


class PasswordWidget extends StatefulWidget {
  final SetPasswordUsecase? setPasswordUsecase;
  final SetGuessUsecase? setGuessUsecase;
  final List<int>? defaultValues;
  const PasswordWidget({Key? key, this.setPasswordUsecase, this.defaultValues, this.setGuessUsecase}) : super(key: key);

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {

  void _putSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      )
    );
  }

  void _setPassword() async {
    if (await widget.setPasswordUsecase?.submit() == false) {
      _putSnack("Invalid password");
    }

    if (await widget.setGuessUsecase?.submit() == false) {
      _putSnack("Invalid password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: Dimensions.height(2)),
          width: Dimensions.width(30),
          color: AppColors.secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dimensions.sizeHor(7),
              for(int i = 0; i < 4; i++) ... [
                BallWidget(index: i, setPasswordUsecase: widget.setPasswordUsecase, value: widget.defaultValues?[i], setGuessUsecase: widget.setGuessUsecase),
                Dimensions.sizeHor(2)
              ],
              SizedBox(
                width: Dimensions.width(5),
                child: widget.setPasswordUsecase != null || widget.setGuessUsecase != null ?
                  AppButton(text: "Enviar", onTap: _setPassword) : const SizedBox(),
              ),
            ],
          ),
        ),
        
      ],
    );
  }
}