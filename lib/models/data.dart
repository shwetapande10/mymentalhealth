class SelectionIconData {
  String name;
  String image;
  bool isSelected;
  SelectionIconData(this.image, this.name, this.isSelected);
}

List<SelectionIconData> moodIcons = [
  SelectionIconData('assets/smile.png', 'Happy', false),
  SelectionIconData('assets/sad.png', 'Sad', false),
  SelectionIconData('assets/angry.png', 'Angry', false),
  SelectionIconData('assets/amazed.png', 'Amazed', false),
  SelectionIconData('assets/loving.png', 'Loving', false),
  SelectionIconData('assets/scared.png', 'Scared', false)
];

List<SelectionIconData> activityIcons = [
  SelectionIconData('assets/sports.png', 'Sports', false),
  SelectionIconData('assets/sleeping.png', 'Sleep', false),
  SelectionIconData('assets/shop.png', 'Shop', false),
  SelectionIconData('assets/relax.png', 'Relax', false),
  SelectionIconData('assets/reading.png', 'Read', false),
  SelectionIconData('assets/movies.png', 'Movies', false),
  SelectionIconData('assets/gaming.png', 'Gaming', false),
  SelectionIconData('assets/friends.png', 'Friends', false),
  SelectionIconData('assets/family.png', 'Family', false),
  SelectionIconData('assets/exercise.png', 'Exercise', false),
  SelectionIconData('assets/eat.png', 'Eat', false),
  SelectionIconData('assets/date.png', 'Date', false),
  SelectionIconData('assets/clean.png', 'Clean', false)
];

class MoodDate {
  String mood;
  String date;
  MoodDate(this.mood, this.date);
}
