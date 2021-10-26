import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColour;
  final GestureTapCallback onPress;
  const ActionWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColour,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: CircleAvatar(
            radius: 27,
            backgroundColor: iconColour,
            child: CircleAvatar(
              radius: 25,
              child: Icon(icon, color: iconColour, size: 30),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 2.5),
        Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: iconColour, fontSize: 15))
      ],
    );
  }
}
