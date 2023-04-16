import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:testcapstone/pages/location.dart';

const imgTabbar = "assets/supergraphic.svg";

class FuelLvlPara extends StatefulWidget {
  const FuelLvlPara({super.key});

  @override
  State<FuelLvlPara> createState() => _FuelLvlParaState();
}

class _FuelLvlParaState extends State<FuelLvlPara> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    LocalNotif();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fuel Level",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SfRadialGauge(
              animationDuration: 5,
              axes: <RadialAxis>[
                RadialAxis(
                    startAngle: 180,
                    endAngle: 0,
                    showTicks: false,
                    showAxisLine: false,
                    showLabels: false,
                    canScaleToFit: true,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: 10,
                          startWidth: 10,
                          endWidth: 12.5,
                          color: _color1),
                      GaugeRange(
                          startValue: 12,
                          endValue: 20,
                          startWidth: 12.5,
                          endWidth: 15,
                          color: _color2),
                      GaugeRange(
                          startValue: 22,
                          endValue: 30,
                          startWidth: 15,
                          endWidth: 17.5,
                          color: _color3),
                      GaugeRange(
                          startValue: 32,
                          endValue: 40,
                          startWidth: 17.5,
                          endWidth: 20,
                          color: _color4),
                      GaugeRange(
                          startValue: 42,
                          endValue: 50,
                          startWidth: 20,
                          endWidth: 22.5,
                          color: _color5),
                      GaugeRange(
                          startValue: 52,
                          endValue: 60,
                          startWidth: 22.5,
                          endWidth: 25,
                          color: _color6),
                      GaugeRange(
                          startValue: 62,
                          endValue: 70,
                          startWidth: 25,
                          endWidth: 27.5,
                          color: _color7),
                      GaugeRange(
                          startValue: 72,
                          endValue: 80,
                          startWidth: 27.5,
                          endWidth: 30,
                          color: _color8),
                      GaugeRange(
                          startValue: 82,
                          endValue: 90,
                          startWidth: 30,
                          endWidth: 32.5,
                          color: _color9),
                      GaugeRange(
                          startValue: 92,
                          endValue: 100,
                          startWidth: 32.5,
                          endWidth: 35,
                          color: _color10)
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                          value: _value,
                          enableAnimation: true,
                          needleEndWidth: 7,
                          onValueChanged: _onPointerValueChanged,
                          needleStartWidth: 1,
                          needleColor: Colors.red,
                          needleLength: 0.85,
                          knobStyle: const KnobStyle(
                              color: Colors.black, knobRadius: 0.09))
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              width: 30.00,
                              height: 30.00,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage('assets/fuel.png'),
                                  fit: BoxFit.fill,
                                ),
                              )),
                          angle: 270,
                          positionFactor: 0.35),
                      const GaugeAnnotation(
                          widget: Text(
                            'E',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          angle: 175,
                          positionFactor: 1),
                      const GaugeAnnotation(
                          widget: Text(
                            'F',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          angle: 5,
                          positionFactor: 0.95),
                    ])
              ],
            ),
            Text(
              _value.toString(),
              style: const TextStyle(fontSize: 20),
            ),
            Slider(
                min: 0,
                max: 100,
                divisions: 100,
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                })
          ],
        ),
      ),
    );
  }

  void LocalNotif() {
    setState(() {
      if (_value >= 0 && _value <= 10) {
        Notify();
      }
    });
  }

  void _onPointerValueChanged(double _value) {
    setState(() {
      if (_value >= 0 && _value <= 10) {
        _onFirstRangeColorChanged();
      } else if (_value >= 10 && _value <= 20) {
        _onSecondRangeColorChanged();
      } else if (_value >= 20 && _value <= 30) {
        _onThirdRangeColorChanged();
      } else if (_value >= 30 && _value <= 40) {
        _onFourthRangeColorChanged();
      } else if (_value >= 40 && _value <= 50) {
        _onFifthRangeColorChanged();
      } else if (_value >= 50 && _value <= 60) {
        _onSixthRangeColorChanged();
      } else if (_value >= 60 && _value <= 70) {
        _onSeventhRangeColorChanged();
      } else if (_value >= 70 && _value <= 80) {
        _onEighthRangeColorChanged();
      } else if (_value >= 80 && _value <= 90) {
        _onNinethRangeColorChanged();
      } else if (_value >= 90 && _value <= 100) {
        _onTenthRangeColorChanged();
      }
    });
  }

  void _onFirstRangeColorChanged() {
    _color1 = Colors.red;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSecondRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.red;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onThirdRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.red;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onFourthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.red;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onFifthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.red;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSixthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.red;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSeventhRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.red;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onEighthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.red;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onNinethRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.red;
    _color10 = Colors.black;
  }

  void _onTenthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.red;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.red;
  }

  Color _color1 = Colors.red;
  Color _color2 = Colors.black;
  Color _color3 = Colors.black;
  Color _color4 = Colors.black;
  Color _color5 = Colors.black;
  Color _color6 = Colors.black;
  Color _color7 = Colors.black;
  Color _color8 = Colors.black;
  Color _color9 = Colors.black;
  Color _color10 = Colors.black;
}

void Notify() async {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic_channel",
        title: "Run Out of Gas!!! " + Emojis.symbols_warning,
        body: "Alert Run Out Of Gas",
        bigPicture: 'asset://assets/alert.jpg',
        displayOnForeground: true,
        displayOnBackground: true,
        notificationLayout: NotificationLayout.BigPicture,
      ),
      actionButtons: [
        // NotificationActionButton(
        //     key: 'Fuel',
        //     label: 'Direct to Gas Station?',
        //     actionType: ActionType.Default,
        //     isDangerousOption: true),
        NotificationActionButton(
            key: 'DISMISS',
            label: 'Dismiss',
            actionType: ActionType.DismissAction,
            color: Colors.white,
            isDangerousOption: true)
      ]);
}

// onSigned() {
//   Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const LocationPage(),
//       ),
//       (route) => false);
// }
