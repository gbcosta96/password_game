import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/lobby/lobby_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBxckOi_mqAmq2IbCNsDtvi7Fcwei0jlJU",
      appId: "1:921105448683:web:6bca045bb5e3669309c8ae",
      messagingSenderId: "921105448683",
      projectId: "password-game01",
    ),
  );
  } else {
    await Firebase.initializeApp();
  }
  
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