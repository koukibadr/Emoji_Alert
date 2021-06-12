import 'package:emoji_alert/constants.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/arrays.dart';
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
      alertTitle: Text("Alert Title",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      description: Text("Please enter your name"),
      height: 300,
      enableMainButton: true,
      mainButtonText: Text("Confirmer"),
      mainButtonColor: Colors.green,
      onMainButtonPressed: () {
        print("Hello I'm Badr");
      },
      cancelable: false,
      enableSecondaryButton: true,
      onSecondaryButtonPressed: () {
        Navigator.pop(context);
      },
      cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
      width: 400,
      emojiType: EMOJI_TYPE.ANGRY,
    ).displayAlert(context);
  }
}
