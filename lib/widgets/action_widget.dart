import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final GestureTapCallback onPress;

  const ActionWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
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
            child: CircleAvatar(
                child: Icon(icon, color: iconColor, size: 30),
                radius: 25,
                backgroundColor: Colors.white),
            backgroundColor: iconColor,
          ),
        ),
        const SizedBox(height: 2.5),
        Text(text,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: iconColor, fontSize: 15))
      ],
    );
  }
}
