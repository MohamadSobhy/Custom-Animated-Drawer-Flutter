import 'package:flutter/material.dart';

class DrawerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Container(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Messages',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'About app',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
          ],
        ));
  }
}
