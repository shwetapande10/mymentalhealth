import 'package:flutter/material.dart';
import 'package:mymentalhealth/models/mood_data.dart';
import 'package:mymentalhealth/widgets/selection_icon.dart';

class SelectionList extends StatelessWidget {
  final List<SelectionIconData> iconList;
  final Function(int) onSelection;

  const SelectionList({
    Key? key,
    required this.iconList,
    required this.onSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: iconList.length,
          itemBuilder: (context, index) {
            return SelectionIcon(
                onPress: () {
                  onSelection(index);
                },
                data: iconList[index]);
          }),
    );
  }
}
