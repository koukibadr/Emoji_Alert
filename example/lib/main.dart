import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/emoji_type.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: InkWell(
                onTap: () {
                  displayAlert(context);
                },
                child: Text("Emoji Alert Example"))),
      ),
    );
  }

  displayAlert(context) {
    EmojiAlert(
      description: "My name is badreddine and this is a new alert",
      emojiType: EMOJI_TYPE.CONFUSED,
      alertTitle: "Alert",
      enableTitle: true,
      height: 400,
    ).show(context);
  }
}
