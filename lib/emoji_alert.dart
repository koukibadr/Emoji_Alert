import 'package:flutter/material.dart';

class EmojiAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Color(0x00000000),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image(image: AssetImage("assets/images/happy.png", package: 'emoji_alert'),width: 70,),
          ),
        ],
      ),
    );
  }

  show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: this,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
          );
        });
  }
}
