import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymentalhealth/helpers/mood_data.dart';
import 'package:mymentalhealth/models/moodcard_provider.dart';
import 'package:mymentalhealth/widgets/chart_holder.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class MoodChart extends StatefulWidget {
  const MoodChart({Key? key}) : super(key: key);

  @override
  _MoodChartState createState() => _MoodChartState();
}

class _MoodChartState extends State<MoodChart> {
  late Map<String, double> moodScore = {
    moods[0].name: 0,
    moods[1].name: 0,
    moods[2].name: 0,
    moods[3].name: 0,
    moods[4].name: 0,
    moods[5].name: 0
  };

  Map<String, double> activityScore = {
    activities[0].name: 0,
    activities[1].name: 0,
    activities[2].name: 0,
    activities[3].name: 0,
    activities[4].name: 0,
    activities[5].name: 0,
    activities[6].name: 0,
    activities[7].name: 0,
    activities[8].name: 0,
    activities[9].name: 0,
    activities[10].name: 0,
    activities[11].name: 0,
    activities[12].name: 0
  };

  @override
  void initState() {
    super.initState();
    Provider.of<MoodCardProvider>(context, listen: false).data.forEach((element) {
      moodScore[element.mood] = (moodScore[element.mood] ?? 0) + 1;
    });

    Provider.of<MoodCardProvider>(context, listen: false)
        .activityNames
        .forEach((element) {
      activityScore[element] = (activityScore[element] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MoodData> data = Provider.of<MoodCardProvider>(context, listen: true).data;
    List<charts.Series<MoodData, String>> series = [
      charts.Series(
          id: 'Moods',
          data: data,
          domainFn: (MoodData series, _) => series.date,
          measureFn: (MoodData series, _) =>
              moods.indexWhere((element) => element.name == series.mood) + 1)
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

  Column barchart(List<charts.Series<MoodData, String>> series) {
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
                        "${index + 1} - ${moods[index].name}",
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
