import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_alert/resources/arrays.dart';
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
      debugShowCheckedModeBanner: false,
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Simple example with miniumum parameters'),
            ElevatedButton(
              onPressed: () {
                displayAlert(context);
              },
              child: Text('Happy Alert'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Alert with custom body widgets (textfield)'),
            ElevatedButton(
              onPressed: () {
                displayShockedAlert(context);
              },
              child: Text('Joyful Alert'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Alert with main button example with press handler'),
            ElevatedButton(
              onPressed: () {
                displayAngryAlert(context);
              },
              child: Text('Angry Alert'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Alert with multiple buttons example'),
            ElevatedButton(
              onPressed: () {
                displayCoolAlert(context);
              },
              child: Text('Multiple buttons Alert'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Emoji alert displayed as a bottom sheet modal'),
            ElevatedButton(
              onPressed: () {
                displayBottomSheetAlert(context);
              },
              child: Text('Bottom Sheet Alert'),
            ),
          ],
        ),
      ),
    );
  }

  void displayAlert(context) {
    EmojiAlert(
      alertTitle: Text(
        'Emoji Alert',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      height: 250,
      description: Column(
        children: [
          Text('Simple Example with animation'),
          Text('This is a transition animation'),
        ],
      ),
      enableMainButton: true,
      animationType: ANIMATION_TYPE.transition,
    ).displayAlert(context);
  }

  void displayShockedAlert(context) {
    EmojiAlert(
      alertTitle: Text(
        'Joyful Alert',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Column(
        children: [
          Text('You can add also any widget'),
          Container(
            width: 200,
            child: TextField(
              decoration: InputDecoration(hintText: 'Input field example'),
            ),
          ),
        ],
      ),
      cancelable: true,
      emojiType: EMOJI_TYPE.joyful,
      height: 300,
    ).displayAlert(context);
  }

  void displayAngryAlert(context) {
    EmojiAlert(
      alertTitle: Text(
        'Angry Alert',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Column(
        children: [
          Text('You can add a main button'),
        ],
      ),
      enableMainButton: true,
      mainButtonColor: Colors.red,
      onMainButtonPressed: () {
        Navigator.pop(context);
      },
      cancelable: false,
      emojiType: EMOJI_TYPE.angry,
      height: 300,
    ).displayAlert(context);
  }

  void displayCoolAlert(context) {
    EmojiAlert(
      alertTitle: Text(
        'Cool Alert',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Column(
        children: [
          Text(
            'You can add multiple buttons',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
      enableMainButton: true,
      enableSecondaryButton: true,
      mainButtonColor: Colors.green,
      secondaryButtonColor: Colors.green,
      mainButtonText: Text('Save'),
      secondaryButtonText: Text('Discard'),
      cancelable: true,
      emojiType: EMOJI_TYPE.cool,
      height: 300,
    ).displayAlert(context);
  }

  void displayBottomSheetAlert(context) {
    EmojiAlert(
      alertTitle: Text(
        'Bottom Sheet Modal',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Column(
        children: [
          Text(
            'And this is a bottom sheet modal with different Radius',
            style: TextStyle(
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      enableMainButton: true,
      cornerRadiusType: CORNER_RADIUS_TYPES.topOnly,
      mainButtonColor: Colors.green,
      mainButtonText: Text('Save'),
      onMainButtonPressed: () {
        Navigator.pop(context);
        displayAngryAlert(context);
      },
      cancelable: true,
      emojiType: EMOJI_TYPE.smile,
      width: 300,
      height: 300,
    ).displayBottomSheet(context);
  }
}
