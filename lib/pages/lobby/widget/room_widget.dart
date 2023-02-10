import 'package:flutter/material.dart';
import 'package:password_game/dimensions.dart';
import 'package:password_game/widgets/app_button.dart';
import 'package:password_game/widgets/app_text.dart';

import '../../../const.dart';

class RoomWidget extends StatelessWidget {
  final String roomId;
  final Color? color;
  final GestureTapCallback? onTap;
  const RoomWidget({Key? key, required this.roomId, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.smallest(1)),
      child: Container(
        color: AppColors.secondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppText(roomId, bold: true),
            Padding(
              padding: EdgeInsets.all(Dimensions.smallest(2)),
              child: AppButton(onTap: onTap, text: "Entrar"),
            )
          ],
        ),
      ),
    );
  }
}