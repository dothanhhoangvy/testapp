import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';
import 'dart:math' as math;
import "package:http/http.dart" as http;
import 'package:testcapstone/NetworkHandler.dart';
import 'package:testcapstone/data/data.dart';

const imgTabbar = "assets/supergraphic.svg";

class TempPara extends StatefulWidget {
  const TempPara({super.key});

  @override
  State<TempPara> createState() => _TempParaState();
}

class _TempParaState extends State<TempPara> {
  Timer? timer;
  // double _value = double.parse(dataModel.temp as String);
  bool circular =true;
  NetworkHandler networkHandler = NetworkHandler();
  // DataModel? dataModel = DataModel();
  late TooltipBehavior _tooltipBehavior;
  Map<String,dynamic>? datamap;
  Map<String,dynamic>?DoneDataMap;
  Future hitAPI()async{
    http.Response response;
    response=await http.get(Uri.parse("http://192.168.1.108:3001/home/data/tempt"));
    if(response.statusCode==200){
      setState(() {
        datamap = jsonDecode(response.body);
        DoneDataMap = datamap!['temperature'];
        circular =false;
      });
    }

  }
  @override
  void initState() {
    super.initState();
    hitAPI();
    // fetchData();
  }
  // void fetchData() async {
  //   var response = await networkHandler.get("/home/data/tempt");
  //   setState(() {
  //     dataModel=DataModel.fromJson(response!["data"]);
  //     circular =false;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // _getChartData();
    // timer = Timer.periodic(const Duration(milliseconds: 5000), (_timer) {
    //   setState(() {
    //     LocalNotif();
    //     _getChartData();
    //     // dataModel.temp = (math.Random().nextInt() * 40) + 60;
    //     // dataModel.temp = double.parse(dataModel.temp!.toStringAsFixed(1)) as int?;
    //   });
    // });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Engine Temperature",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black, // <-- SEE HERE
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: SizedBox(
              height: 10,
              width: double.infinity,
              child: SvgPicture.asset(
                imgTabbar,
                fit: BoxFit.cover,
              ),
            )),
      ),
      body: circular ? CircularProgressIndicator() : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfLinearGauge(
                minimum: 0,
                maximum: 160,
                orientation: LinearGaugeOrientation.vertical,
                majorTickStyle: const LinearTickStyle(
                    length: 10, thickness: 2.5, color: Colors.black),
                minorTickStyle: const LinearTickStyle(
                    length: 5, thickness: 1.75, color: Colors.black),
                minorTicksPerInterval: 9,
                axisLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                labelOffset: 5,
                markerPointers: [
                  LinearShapePointer(
                    value: double.parse(DoneDataMap! as String) ,
                    color: Colors.red,
                    shapeType: LinearShapePointerType.triangle,
                    offset: 5,
                    position: LinearElementPosition.inside,
                  )
                ],
                ranges: const <LinearGaugeRange>[
                  //First range
                  LinearGaugeRange(
                      startValue: 0, endValue: 50, color: Colors.green),
                  //Second range
                  LinearGaugeRange(
                      startValue: 50, endValue: 100, color: Colors.blue),
                  LinearGaugeRange(
                      startValue: 100, endValue: 160, color: Colors.red),
                ],
              ),
            ),
            // SingleChildScrollView(
            //   child: SfCartesianChart(
            //     title: ChartTitle(text: "Engine Temperature Analysis"),
            //     // legend: Legend(isVisible: true),
            //     tooltipBehavior: _tooltipBehavior,
            //     series: <LineSeries<_ChartData, num>>[
            //       LineSeries<_ChartData, num>(
            //         name: "Temp",
            //         dataSource: _chartData!,
            //         xValueMapper: (_ChartData sales, _) => sales.x,
            //         yValueMapper: (_ChartData sales, _) => sales.y,
            //         enableTooltip: true,
            //         dataLabelSettings: const DataLabelSettings(
            //           isVisible: true,
            //           textStyle: TextStyle(
            //               fontStyle: FontStyle.normal,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 10),
            //         ),
            //       )
            //     ],
            //     primaryXAxis: NumericAxis(
            //         majorGridLines: const MajorGridLines(width: 0),
            //         edgeLabelPlacement: EdgeLabelPlacement.shift,
            //         interval: 3,
            //         title: AxisTitle(text: 'Time (seconds)')),
            //     primaryYAxis: NumericAxis(
            //       labelFormat: '{value}°C',
            //       axisLine: const AxisLine(width: 0),
            //       majorTickLines: const MajorTickLines(size: 0),
            //       title: AxisTitle(text: 'Engine Temperature (°C)'),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // timer?.cancel();
    // _chartData!.clear();
  }

  // int _getRandomInt(int min, int max) {
  //   final math.Random random = math.Random();
  //   return min + random.nextInt(max - min);
  // }

  // void _getChartData() {
  //   _chartData = <_ChartData>[];
  //   for (int i = 0; i <= 10; i++) {
  //     _chartData!.add(_ChartData(i, _getRandomInt(0, 150)));
  //   }
  //   timer?.cancel();
  // }

  // void LocalNotif() {
  //   setState(() {
  //     if (DoneDataMap! >= 60) {
  //       Notify();
  //     }
  //   });
  // }
}

// List<_ChartData>? _chartData;

// class _ChartData {
//   _ChartData(this.x, this.y);
//   final int x;
//   final int y;
// }

void Notify() async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic_channel",
        title: "Temperature over!!! " + Emojis.symbols_warning,
        body: "Alert over Temperature",
        bigPicture: 'asset://assets/alert.jpg',
        displayOnForeground: true,
        displayOnBackground: true,
        notificationLayout: NotificationLayout.BigPicture,
      ),
      actionButtons: [
        NotificationActionButton(
            key: 'DISMISS',
            label: 'Dismiss',
            actionType: ActionType.DismissAction,
            isDangerousOption: true)
      ]);
}
