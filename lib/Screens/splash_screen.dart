import 'dart:async';

import 'package:flutter/material.dart';
import 'package:covid_app/Screens/world_stats.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => WorldStates())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Covid - 19 Tracker',
              style: TextStyle(
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
