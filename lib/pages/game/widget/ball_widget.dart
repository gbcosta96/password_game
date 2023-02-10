import 'package:flutter/material.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/widgets/app_text.dart';

import '../../../usecases/game/set_guess_usecase.dart';
import '../../../usecases/game/set_password_usecase.dart';

class BallWidget extends StatefulWidget {
  final int? value;
  final int index;
  final SetPasswordUsecase? setPasswordUsecase;
  final SetGuessUsecase? setGuessUsecase;
  const BallWidget({Key? key, this.value, this.setPasswordUsecase, required this.index, this.setGuessUsecase}) : super(key: key);

  @override
  State<BallWidget> createState() => _BallWidgetState();
}

class _BallWidgetState extends State<BallWidget> {
  final List<Color> _colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.black, Colors.purple];
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? -1;
  }

  void _changeColor() {
    if (widget.setGuessUsecase != null || widget.setPasswordUsecase != null) {
      _value += 1;
      _value %= _colors.length;
      setState(() {});
      widget.setPasswordUsecase?.setPassword(widget.index, _value);
      widget.setGuessUsecase?.setGuess(widget.index, _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: Container(
        width: Dimensions.smallest(6),
        height: Dimensions.smallest(6),
        decoration: BoxDecoration(
          color: _value == -1 ? Colors.grey : _colors[_value],
          borderRadius: BorderRadius.circular(200),
        ),
        child: Center(child: AppText(_value == -1 ? "?" : "", size: 48, bold: true)),
      ),
    );
  }
}