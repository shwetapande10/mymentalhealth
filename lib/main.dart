import 'package:flutter/material.dart';
import 'package:mymentalhealth/models/moodcard.dart';
import 'package:mymentalhealth/screens/chart.dart';
import 'package:mymentalhealth/screens/mood_activity.dart';
import 'package:mymentalhealth/screens/start.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: MoodCard(),
        child: MaterialApp(
          title: 'My mental health',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const StartPage(),
          routes: {
            '/mood_activity': (ctx) => const MoodActivityScreen(),
            '/chart': (ctx) => const MoodChart(),
          },
        ));
  }
}
