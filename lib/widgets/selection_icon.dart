import 'package:flutter/material.dart';
import 'package:mymentalhealth/models/mood_data.dart';

class SelectionIcon extends StatelessWidget {
  final SelectionIconData data;
  final GestureTapCallback onPress;

  const SelectionIcon({
    Key? key,
    required this.data,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: onPress,
        child: Container(
          child: Column(
            children: [
              Image.asset(data.image, height: 50, width: 45),
              Text(data.name)
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: data.isSelected ? Colors.black : Colors.white),
          ),
          height: 85,
          width: 65,
        ),
      )
    ]);
  }
}
