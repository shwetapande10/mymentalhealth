import 'package:flutter/material.dart';

class MoodIcon extends StatelessWidget {
  final String image;
  final String name;
  final Color colour;
  const MoodIcon(
      {Key? key, required this.name, required this.image, required this.colour})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 50,
            width: 45,
          ),
          Text(name)
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: colour),
      ),
      height: 85,
      width: 65,
    );
  }
}
