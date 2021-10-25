import 'package:flutter/material.dart';
import 'package:mymentalhealth/models/moodcard_provider.dart';
import 'package:provider/provider.dart';

class MoodActivity extends StatefulWidget {
  final String? datetime;
  final String mood;
  final String image;
  List<String?> imageList = [];
  List<String?> nameList = [];

  MoodActivity(
      this.image, this.datetime, this.mood, this.imageList, this.nameList,
      {Key? key})
      : super(key: key);

  @override
  _MoodActivityState createState() => _MoodActivityState();
}

class _MoodActivityState extends State<MoodActivity> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: 80,
        child: Card(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  child: Image.asset(widget.image),
                  height: 45,
                  width: 45,
                ),
                const SizedBox(width: 15),
                Text(
                  widget.mood,
                  style: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.datetime ?? 'nothing',
                  style: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(width: 30),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      Provider.of<MoodCardProvider>(context, listen: false)
                          .isLoading = true;
                      await Provider.of<MoodCardProvider>(context,
                              listen: false)
                          .deletePlaces(widget.datetime ?? "");
                      Provider.of<MoodCardProvider>(context, listen: false)
                          .isLoading = false;
                    })
              ],
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 80),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.imageList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Image.asset(widget.imageList[index] ?? ""),
                            const SizedBox(width: 25)
                          ],
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 80),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.nameList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Text(
                              widget.nameList[index] ?? 'nothinng',
                              style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            const SizedBox(width: 10)
                          ],
                        );
                      }),
                ],
              ),
            ),
          ]),
        ));
  }
}
