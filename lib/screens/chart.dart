import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/db_helper.dart';
import 'package:mymentalhealth/models/data.dart';
import 'package:mymentalhealth/widgets/chart_holder.dart';
import 'package:pie_chart/pie_chart.dart';

class MoodChart extends StatefulWidget {
  const MoodChart({Key? key}) : super(key: key);

  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  late Map<String, double> moodScore = {
    moodIcons[0].name: 0,
    moodIcons[1].name: 0,
    moodIcons[2].name: 0,
    moodIcons[3].name: 0,
    moodIcons[4].name: 0,
    moodIcons[5].name: 0
  };

  Map<String, double> activityScore = {
    activityIcons[0].name: 0,
    activityIcons[1].name: 0,
    activityIcons[2].name: 0,
    activityIcons[3].name: 0,
    activityIcons[4].name: 0,
    activityIcons[5].name: 0,
    activityIcons[6].name: 0,
    activityIcons[7].name: 0,
    activityIcons[8].name: 0,
    activityIcons[9].name: 0,
    activityIcons[10].name: 0,
    activityIcons[11].name: 0,
    activityIcons[12].name: 0
  };

  List<MoodDate> mooddateTimeList = [];

  @override
  void initState() {
    super.initState();
    DBHelper.getData('user_moods').then((value) {
      setState(() {
        mooddateTimeList =
            value.toList().map((e) => MoodDate(e["mood"], e["date"])).toList();
        var activityNames =
            value.toList().expand((e) => e["activityName"].split("_"));
        for (var element in activityNames) {
          activityScore[element] = (activityScore[element] ?? 0) + 1;
        }
        var moods = mooddateTimeList.map((e) => e.mood);
        for (var element in moods) {
          moodScore[element] = (moodScore[element] ?? 0) + 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<MoodDate, String>> series = [
      charts.Series(
          id: 'Moods',
          data: mooddateTimeList,
          domainFn: (MoodDate series, _) => series.date,
          measureFn: (MoodDate series, _) =>
              moodIcons.indexWhere((element) => element.name == series.mood) +
              1)
    ];

    return Scaffold(
      appBar:
          AppBar(title: const Text('Mood Graph'), backgroundColor: Colors.blue),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        children: <Widget>[
          barchart(series),
          Container(
            height: 30,
          ),
          moodChart(context),
          Container(
            height: 30,
          ),
          activityChart(context)
        ],
      ),
    );
  }

  SizedBox activityChart(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ChartHolder(
        PieChart(
          dataMap: activityScore,
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 32.0,
          chartRadius: MediaQuery.of(context).size.width / 2.7,
          chartType: ChartType.disc,
          legendOptions: const LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
          ),
        ),
      ),
    );
  }

  SizedBox moodChart(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ChartHolder(
        PieChart(
          dataMap: moodScore,
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 32.0,
          chartRadius: MediaQuery.of(context).size.width / 2.7,
          chartType: ChartType.disc,
          legendOptions: const LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
          ),
        ),
      ),
    );
  }

  Column barchart(List<charts.Series<MoodDate, String>> series) {
    return Column(
      children: [
        SizedBox(
          height: 108,
          width: 300,
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: (300 - 30) / (108 - 30),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            children: List.generate(
                6,
                (index) => ChartHolder(
                      Text(
                        "${index + 1} - ${moodIcons[index].name}",
                        textAlign: TextAlign.center,
                      ),
                      direction: 1,
                    )),
          ),
        ),
        SizedBox(
          height: 200,
          child: ChartHolder(
            charts.BarChart(
              series,
              animate: true,
            ),
          ),
        ),
      ],
    );
  }
}
