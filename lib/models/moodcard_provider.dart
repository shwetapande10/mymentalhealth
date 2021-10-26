import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';

class MoodCardProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> addPlace(String datetime, String mood, String image,
      String activityImage, String activityName, String date) async {
    isLoading = true;
    DBHelper.insert('user_moods', {
      'datetime': datetime,
      'mood': mood,
      'image': image,
      'activityImage': activityImage,
      'activityName': activityName,
      'date': date
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePlaces(String datetime) async {
    isLoading = true;
    DBHelper.delete(datetime);
    isLoading = false;
    notifyListeners();
  }
}
