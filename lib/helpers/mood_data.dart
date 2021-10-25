import 'package:mymentalhealth/models/activity.dart';
import 'package:mymentalhealth/models/mood.dart';

class MoodData {
  late String date;
  late String mood;

  MoodData(this.mood, this.date);
}

List<Mood> moods = [
  Mood('assets/smile.png', 'Happy', false),
  Mood('assets/sad.png', 'Sad', false),
  Mood('assets/angry.png', 'Angry', false),
  Mood('assets/amazed.png', 'Amazed', false),
  Mood('assets/loving.png', 'Loving', false),
  Mood('assets/scared.png', 'Scared', false)
];

List<Activity> activities = [
  Activity('assets/sports.png', 'Sports', false),
  Activity('assets/sleeping.png', 'Sleep', false),
  Activity('assets/shop.png', 'Shop', false),
  Activity('assets/relax.png', 'Relax', false),
  Activity('assets/reading.png', 'Read', false),
  Activity('assets/movies.png', 'Movies', false),
  Activity('assets/gaming.png', 'Gaming', false),
  Activity('assets/friends.png', 'Friends', false),
  Activity('assets/family.png', 'Family', false),
  Activity('assets/exercise.png', 'Exercise', false),
  Activity('assets/eat.png', 'Eat', false),
  Activity('assets/date.png', 'Date', false),
  Activity('assets/clean.png', 'Clean', false)
];
