import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/helpers/mood_data.dart';
import 'package:mymentalhealth/models/moodcard.dart';
import 'package:mymentalhealth/widgets/mooddaycard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    loader = Provider.of<MoodCard>(context, listen: true).isLoading;
    return loader
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('Your Moods'),
              backgroundColor: Colors.red,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.show_chart),
                    onPressed: () => Navigator.of(context).pushNamed('/chart'))
              ],
            ),
            body: FutureBuilder<List>(
              future: DBHelper.getData('user_moods'),
              initialData: List.filled(0, null, growable: true),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, int position) {
                          var imagestring =
                              snapshot.data?[position]['actimage'];
                          List<String> img = imagestring.split('_');
                          List<String> name =
                              snapshot.data?[position]['actname'].split("_");
                          Provider.of<MoodCard>(context, listen: false)
                              .activityImageNames
                              .addAll(name);
                          Provider.of<MoodCard>(context, listen: false)
                              .data
                              .add(MoodData(
                                  snapshot.data?[position]['mood'] == 'Angry'
                                      ? 1
                                      : snapshot.data?[position]['mood'] ==
                                              'Happy'
                                          ? 2
                                          : snapshot.data?[position]['mood'] ==
                                                  'Sad'
                                              ? 3
                                              : snapshot.data?[position]['mood'] ==
                                                      'Surprised'
                                                  ? 4
                                                  : snapshot.data?[position]
                                                              ['mood'] ==
                                                          'Loving'
                                                      ? 5
                                                      : snapshot.data?[position]
                                                                  ['mood'] ==
                                                              'Scared'
                                                          ? 6
                                                          : 7,
                                  snapshot.data?[position]['date'],
                                  snapshot.data?[position]['mood'] == 'Angry'
                                      ? Colors.red
                                      : snapshot.data?[position]['mood'] ==
                                              'Happy'
                                          ? Colors.blue
                                          : snapshot.data?[position]['mood'] ==
                                                  'Sad'
                                              ? Colors.green
                                              : snapshot.data?[position]
                                                          ['mood'] ==
                                                      'Surprised'
                                                  ? Colors.pink
                                                  : snapshot.data?[position]
                                                              ['mood'] ==
                                                          'Loving'
                                                      ? Colors.purple
                                                      : snapshot.data?[position]
                                                                  ['mood'] ==
                                                              'Scared'
                                                          ? Colors.black
                                                          : Colors.white));

                          return MoodDay(
                              snapshot.data?[position]['image'],
                              snapshot.data?[position]['datetime'],
                              snapshot.data?[position]['mood'],
                              img,
                              name);
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          );
  }
}
