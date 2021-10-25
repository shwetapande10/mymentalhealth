import 'package:flutter/material.dart';

class ActivityIcon extends StatelessWidget {
  final String image;
  final String name;
  final Color colour;
  const ActivityIcon(this.image, this.name, this.colour, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 65,
        child: Column(
          children: <Widget>[
            Image.asset(
              image,
              height: 45,
              width: 45,
            ),
            Text(name)
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: colour),
        ));
  }
}
