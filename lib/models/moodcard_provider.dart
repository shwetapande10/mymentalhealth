import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/helpers/mood_data.dart';
import 'package:mymentalhealth/models/activity.dart';

class MoodCardProvider extends ChangeNotifier {
  late String datetime;
  late String mood;
  List<String> activityNameList = [];
  List<String> activityImageList = [];
  late String image;
  late String activityImage;
  late String activityName;
  List items = [];
  List<MoodData> data = [];
  late String date;
  bool isLoading = false;
  List<String> activityNames = [];

  void add(Activity act) {
    activityImageList.add(act.image);
    activityNameList.add(act.name);
    notifyListeners();
  }

  Future<void> addPlace(String datetime, String mood, String image,
      String actImage, String actName, String date) async {
    DBHelper.insert('user_moods', {
      'datetime': datetime,
      'mood': mood,
      'image': image,
      'activityImage': actImage,
      'activityName': actName,
      'date': date
    });
    notifyListeners();
  }

  Future<void> deletePlaces(String datetime) async {
    DBHelper.delete(datetime);
    notifyListeners();
  }
}
