import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/helpers/mood_data.dart';
import 'package:mymentalhealth/models/activity.dart';

class MoodCardProvider extends ChangeNotifier {
  List<String> activityNameList = [];
  List<String> activityImageList = [];
  List<MoodData> data = [];
  bool isLoading = false;
  List<String> activityNames = [];

  void add(Activity act) {
    activityImageList.add(act.image);
    activityNameList.add(act.name);
    notifyListeners();
  }

  Future<void> addPlace(String datetime, String mood, String image,
      String activityImage, String activityName, String date) async {
    DBHelper.insert('user_moods', {
      'datetime': datetime,
      'mood': mood,
      'image': image,
      'activityImage': activityImage,
      'activityName': activityName,
      'date': date
    });
    notifyListeners();
  }

  Future<void> deletePlaces(String datetime) async {
    DBHelper.delete(datetime);
    notifyListeners();
  }
}
