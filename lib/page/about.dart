import 'package:agah/widget/toolbar.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About();

  @override
  AboutState createState() => new AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar.getPrimaryBackAppbar(context, "Barə"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Agah by Agha",
              style: TextStyle(
                fontFamily: 'Regular',
                fontSize: 32.0,
                color: Colors.black87,
              ),
            ),
            Container(height: 5),
            Container(width: 200, height: 3, color: Colors.greenAccent),
            Container(height: 15),
            Text(
              "Versiya",
              style: TextStyle(
                fontFamily: 'Regular',
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "1.0.0.0",
              style: TextStyle(
                fontFamily: 'Regular',
                fontSize: 17.0,
                color: Colors.black45,
              ),
            ),
            Container(height: 15),
            Text(
              "Son yenilənmə",
              style: TextStyle(
                fontFamily: 'Regular',
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            Text(
              "Aprel 29",
              style: TextStyle(
                fontFamily: 'Regular',
                fontSize: 17.0,
                color: Colors.black54,
              ),
            ),
            Container(height: 25),
            Text(
              "Bu proqram bütün xəbərlərə dərgah kimidir.\nBir kəs ki işlədə, hər xəbərdən agah kimidir.",
              style: TextStyle(
                fontFamily: 'Regular',
                fontSize: 17.0,
                color: Colors.black54,
              ),
            ),
            Container(height: 25),
            Text(
              "© Kodachi Agency",
              style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 18.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
