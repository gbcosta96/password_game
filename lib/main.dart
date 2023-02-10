import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/lobby/lobby_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password',
      darkTheme: ThemeData.dark(),
      home: const LobbyPage(),
    );
  }
}