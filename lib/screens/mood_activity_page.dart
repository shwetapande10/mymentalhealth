import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/models/moodcard_provider.dart';
import 'package:mymentalhealth/widgets/mood_activity_list.dart';
import 'package:provider/provider.dart';

class MoodActivityScreen extends StatefulWidget {
  const MoodActivityScreen({Key? key}) : super(key: key);

  @override
  _MoodActivityScreenState createState() => _MoodActivityScreenState();
}

class _MoodActivityScreenState extends State<MoodActivityScreen> {
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    loader = Provider.of<MoodCardProvider>(context, listen: true).isLoading;
    return loader
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Your Moods'),
              backgroundColor: Colors.blue,
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.show_chart),
                    onPressed: () => Navigator.of(context).pushNamed('/chart'))
              ],
            ),
            body: FutureBuilder<List>(
              future: DBHelper.getData('user_moods'),
              initialData: List.filled(0, null, growable: true),
              builder: (context, snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, int position) {
                    return getMoodActivityItem(snapshot, position, context);
                  },
                );
              },
            ),
          );
  }

  MoodActivity getMoodActivityItem(AsyncSnapshot<List<dynamic>> snapshot,
      int position, BuildContext context) {
    var imageString = snapshot.data?[position]['activityImage'];
    List<String> imgList = imageString.split('_');
    List<String> nameList = snapshot.data?[position]['activityName'].split("_");
    return MoodActivity(
        snapshot.data?[position]['image'],
        snapshot.data?[position]['datetime'],
        snapshot.data?[position]['mood'],
        imgList,
        nameList);
  }
}
