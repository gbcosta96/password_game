import 'package:flutter/material.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/models/player_model.dart';
import 'package:password_game/pages/game/widget/password_widget.dart';
import 'package:password_game/widgets/app_text.dart';

import '../../../usecases/game/set_guess_usecase.dart';

class GameWidget extends StatelessWidget {
  final PlayerModel myself;
  final PlayerModel enemy;
  final SetGuessUsecase setGuessUsecase;

  const GameWidget({Key? key, required this.myself, required this.enemy, required this.setGuessUsecase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              AppText(myself.name),
              const AppText("Adivinhe"),
              const PasswordWidget(),
              PasswordWidget(setGuessUsecase: setGuessUsecase),
            ],
          ),
          Dimensions.sizeHor(5),
          Column(
            children: [
              AppText(enemy.name),
              const AppText("Tentando adivinhar"),
              PasswordWidget(defaultValues: myself.password),
              PasswordWidget(defaultValues: enemy.guesses?[0]),

            ],
          )
        ],
      ),
    );
  }
}