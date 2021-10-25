import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/mood_data.dart';
import 'package:mymentalhealth/models/mood.dart';
import 'package:mymentalhealth/models/moodcard_provider.dart';
import 'package:mymentalhealth/widgets/activity.dart';
import 'package:mymentalhealth/widgets/moodicon.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late MoodCardProvider moodCard;
  late String mood;
  late String image;
  late String datetime;
  late int currentIndex;
  late String dateOnly;

  String datePicked = "Please select a date\n";
  String timePicked = "Please select a time";
  int onTapCount = 0;
  Color colour = Colors.white;

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
        body: Column(children: <Widget>[
          const SizedBox(height: 20),
          _pickerRow(context),
          _selectedDateTime(),
          _howAreYouFeelingTitle(),
          _moodSelector(),
          _activityTitle(),
          _activitySelector(),
          _saveButton(context),
          const SizedBox(height: 15)
        ]));
  }

  ElevatedButton _saveButton(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () => {
              setState(() {
                datetime = datePicked + '   ' + timePicked;
                Provider.of<MoodCardProvider>(context, listen: false).addPlace(
                    datetime,
                    mood,
                    image,
                    Provider.of<MoodCardProvider>(context, listen: false)
                        .activityImageList
                        .join('_'),
                    Provider.of<MoodCardProvider>(context, listen: false)
                        .activityNameList
                        .join('_'),
                    dateOnly);
              }),
              Navigator.of(context).pushNamed('/mood_activity'),
            },
        icon: const Icon(Icons.save_alt, size: 20, color: Colors.white),
        label: const Text("Save"));
  }

  Expanded _activitySelector() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return Row(children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                  child: ActivityIcon(
                      activities[index].image,
                      activities[index].name,
                      activities[index].isSelected
                          ? Colors.black
                          : Colors.white),
                  onLongPress: () => {
                        if (activities[index].isSelected)
                          {
                            setState(() {
                              activities[index].isSelected = false;
                            })
                          }
                        else
                          setState(() {
                            activities[index].isSelected = true;
                            Provider.of<MoodCardProvider>(context,
                                    listen: false)
                                .add(activities[index]);
                          }),
                      }),
            ]);
          }),
    );
  }

  Column _activityTitle() {
    return Column(
      children: const [
        Text('What have you been doing?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Hold on the activity to select,You can choose multiple',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Expanded _moodSelector() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: moods.length,
          itemBuilder: (context, index) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  GestureDetector(
                      child: MoodIcon(
                          image: moods[index].moodImage,
                          name: moods[index].name,
                          colour: moods[index].isSelected
                              ? Colors.black
                              : Colors.white),
                      onTap: () => {
                            if (onTapCount == 0)
                              setState(() {
                                selectMood(moods[index]);
                              })
                            else
                              setState(() {
                                deselectMood(moods[index]);
                              })
                          }),
                ],
              ),
            );
          }),
    );
  }

  selectMood(Mood element) {
    mood = element.name;
    image = element.moodImage;
    element.isSelected = true;
    onTapCount = onTapCount + 1;
  }

  deselectMood(Mood element) {
    if (element.isSelected) {
      element.isSelected = false;
      onTapCount = 0;
    }
  }

  Column _howAreYouFeelingTitle() {
    return Column(
      children: const [
        Text('How are you feeling now?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text('(Tap to Select and Tap again to deselect!)',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Column _selectedDateTime() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text("$datePicked $timePicked",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
      ],
    );
  }

  Row _pickerRow(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/mood_activity');
            },
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 27,
                  child: CircleAvatar(
                      child:
                          Icon(Icons.dashboard, color: Colors.green, size: 30),
                      radius: 25,
                      backgroundColor: Colors.white),
                  backgroundColor: Colors.green,
                ),
                SizedBox(height: 2.5),
                Text('Dashboard',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 15))
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2022));
              setState(() {
                datePicked =
                    "${date?.day.toString()}-${date?.month.toString()}-${date?.year.toString()}";
                dateOnly = "${date?.day.toString()}/${date?.month.toString()}";
              });
            },
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 27,
                  child: CircleAvatar(
                      child: Icon(Icons.calendar_today,
                          color: Colors.blue, size: 30),
                      radius: 25,
                      backgroundColor: Colors.white),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(
                  height: 2.5,
                ),
                Text('Pick a date',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        fontSize: 15))
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              var time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              setState(() {
                timePicked = time?.format(context).toString() ?? "12:00 AM";
              });
            },
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 27,
                  child: CircleAvatar(
                      child: Icon(Icons.timer, color: Colors.red, size: 30),
                      radius: 25,
                      backgroundColor: Colors.white),
                  backgroundColor: Colors.red,
                ),
                SizedBox(
                  height: 2.5,
                ),
                Text('Pick a time',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                        fontSize: 15))
              ],
            ),
          ),
        ]);
  }
}
