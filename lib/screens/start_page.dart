import 'package:flutter/material.dart';
import 'package:mymentalhealth/models/mood_data.dart';
import 'package:mymentalhealth/models/moodcard_provider.dart';
import 'package:mymentalhealth/widgets/action_widget.dart';
import 'package:mymentalhealth/widgets/selection_list.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String datePicked = "Please select a date\n";

  late String dateOnly;

  String timePicked = "Please select a time";

  var onTapCount = 0;

  late String datetime;

  late String mood;

  late String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('How am I feeling?',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.insert_emoticon, color: Colors.white, size: 25)
              ],
            ),
            backgroundColor: Colors.blue),
        body: Column(children: [
          const SizedBox(
            height: 20,
          ),
          _actionRow(context),
          Column(
            children: [
              const SizedBox(height: 20),
              Text("$datePicked $timePicked")
            ],
          ),
          Column(
            children: const [
              SizedBox(height: 20),
              Text("What are you feeling now?"),
              Text("Tap to toggle selection"),
              SizedBox(height: 20)
            ],
          ),
          SelectionList(
            onSelection: (index) {
              setState(() {
                if (onTapCount == 0) {
                  mood = moodIcons[index].name;
                  image = moodIcons[index].image;
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
          Column(
            children: const [
              SizedBox(height: 20),
              Text("What you doing?"),
              Text("Tap to toggle selection - multiple selections allowed"),
              SizedBox(height: 20)
            ],
          ),
          SelectionList(
            onSelection: (index) {
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
                onPressed: () => {
                      setState(() {
                        datetime = datePicked + '   ' + timePicked;
                        print(activityIcons
                            .where((element) => element.isSelected)
                            .map((e) => e.name));
                        Provider.of<MoodCardProvider>(context, listen: false)
                            .addPlace(
                                datetime,
                                mood,
                                image,
                                activityIcons
                                    .where((element) => element.isSelected)
                                    .map((e) => e.image)
                                    .join("_"),
                                activityIcons
                                    .where((element) => element.isSelected)
                                    .map((e) => e.name)
                                    .join("_"),
                                dateOnly);
                      }),
                      Navigator.of(context).pushNamed('/mood_activity'),
                    },
                icon: const Icon(Icons.save_alt, size: 20, color: Colors.white),
                label: const Text("Save")),
          )
        ]));
  }

  Row _actionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionWidget(
          icon: Icons.dashboard,
          iconColor: Colors.green,
          text: "Dashboard",
          onPress: () {
            Navigator.of(context).pushNamed('/mood_activity');
          },
        ),
        ActionWidget(
            icon: Icons.calendar_today,
            iconColor: Colors.blue,
            text: "Pick a date",
            onPress: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2022));
              setState(() {
                datePicked = "${date?.day}-${date?.month}-${date?.year}";
                dateOnly = "${date?.day}-${date?.month}";
              });
            }),
        ActionWidget(
          icon: Icons.timer,
          iconColor: Colors.red,
          text: "Pick a time",
          onPress: () async {
            var time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            setState(() {
              timePicked = time?.format(context).toString() ?? "12:00 AM";
            });
          },
        )
      ],
    );
  }
}
