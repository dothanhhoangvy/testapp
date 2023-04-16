import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odometer/odometer.dart';
import 'dart:math' as math;

const imgTabbar = "assets/supergraphic.svg";

class MileagePara extends StatefulWidget {
  const MileagePara({super.key});

  @override
  State<MileagePara> createState() => _MileageParaState();
}

class _MileageParaState extends State<MileagePara> {
  int _counter = 100000;

  void _incrementCounter() {
    setState(() {
      _counter += (math.Random().nextInt(100) + 50);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Mileage",
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
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSlideOdometerNumber(
                groupSeparator: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                odometerNumber: OdometerNumber(_counter),
                duration: const Duration(milliseconds: 1000),
                letterWidth: 35,
                numberTextStyle: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
