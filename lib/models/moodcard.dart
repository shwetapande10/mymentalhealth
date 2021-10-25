import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/helpers/mood_data.dart';
import 'package:mymentalhealth/models/activity.dart';

class MoodCard extends ChangeNotifier {
  String datetime = "12:00 AM";
  String mood = "happy";
  List<String> activityName = [];
  List<String> activityImage = [];
  String image = "smile.png";
  late String actImage;
  late String actName;
  List items = [];
  List<MoodData> data = [];
  String date = "";
  bool isLoading = false;
  List<String> activityImageNames = [];

  void add(Activity act) {
    activityImage.add(act.image);
    activityName.add(act.name);
    notifyListeners();
  }

  Future<void> addPlace(String datetime, String mood, String image,
      String actImage, String actName, String date) async {
    DBHelper.insert('user_moods', {
      'datetime': datetime,
      'mood': mood,
      'image': image,
      'actimage': actImage,
      'actname': actName,
      'date': date
    });
    notifyListeners();
  }

  Future<void> deletePlaces(String datetime) async {
    DBHelper.delete(datetime);
    notifyListeners();
  }
}
