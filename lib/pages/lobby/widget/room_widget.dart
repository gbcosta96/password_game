import 'package:flutter/material.dart';
import 'package:password_game/widgets/app_text.dart';

import '../../../const.dart';

class RoomWidget extends StatelessWidget {
  final String roomId;
  final Color? color;
  final GestureTapCallback? onTap;
  const RoomWidget({Key? key, required this.roomId, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.secondaryColor,
        child: AppText(roomId, bold: true),
      ),
    );
  }
}