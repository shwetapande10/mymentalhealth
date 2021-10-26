import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/models/data.dart';
import 'package:mymentalhealth/widgets/action_widget.dart';
import 'package:mymentalhealth/widgets/selection_list.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late String datePicked = "Please select a date\n";

  late String timePicked = "Please select a time";

  late String dateOnly;

  int onTapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("How am I feeling?"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionWidget(
                    icon: Icons.dashboard,
                    text: "Dashboard",
                    iconColour: Colors.green,
                    onPress: () {
                      Navigator.of(context).pushNamed("/mood_activity_screen");
                    }),
                ActionWidget(
                    icon: Icons.calendar_today,
                    text: "Pick a date",
                    iconColour: Colors.blue,
                    onPress: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2022));
                      setState(() {
                        datePicked =
                            "${date?.day}-${date?.month}-${date?.year}";
                        dateOnly = "${date?.day}-${date?.month}";
                      });
                    }),
                ActionWidget(
                    icon: Icons.timer,
                    text: "Pick a time",
                    iconColour: Colors.red,
                    onPress: () async {
                      var time = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        timePicked =
                            time?.format(context).toString() ?? "12:00 AM";
                      });
                    }),
              ],
            ),
            const SizedBox(height: 20),
            Text("$datePicked $timePicked"),
            const SizedBox(height: 20),
            Text("How is you mood?"),
            Text("Select your mood"),
            SelectionList(
              onSelected: (index) {
                setState(() {
                  if (onTapCount == 0) {
                    moodIcons[index].isSelected = true;
                    onTapCount = onTapCount + 1;
                  } else if (moodIcons[index].isSelected) {
                    moodIcons[index].isSelected = false;
                    onTapCount = 0;
                  }
                });
              },
              iconList: moodIcons,
            ),
            Text("What have you been doing?"),
            Text("Select on or more"),
            SelectionList(
              onSelected: (index) {
                setState(() {
                  activityIcons[index].isSelected =
                      !activityIcons[index].isSelected;
                });
              },
              iconList: activityIcons,
            ),
            SafeArea(
              minimum: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    DBHelper.insert("user_moods", {
                      'datetime': datePicked,
                      'mood': moodIcons
                          .where((element) => element.isSelected)
                          .first
                          .name,
                      'image': moodIcons
                          .where((element) => element.isSelected)
                          .first
                          .image,
                      'activityImage': activityIcons
                          .where((element) => element.isSelected)
                          .map((e) => e.image)
                          .join("_"),
                      'activityName': activityIcons
                          .where((element) => element.isSelected)
                          .map((e) => e.name)
                          .join("_"),
                      'date': dateOnly
                    });
                    Navigator.of(context).pushNamed("/mood_activity_screen");
                  },
                  icon: const Icon(Icons.save, size: 20, color: Colors.white),
                  label: const Text("Save")),
            )
          ],
        ));
  }
}
