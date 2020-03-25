import 'package:flutter/material.dart';

import 'src/screens/custom_aimated_drawer_screen.dart';

void main() => runApp(MyApp());

const MaterialColor primaryColorShades = MaterialColor(
  0xFF343442,
  <int, Color>{
    50: Color(0xFF343442),
    100: Color(0xFF343442),
    200: Color(0xFF343442),
    300: Color(0xFF343442),
    400: Color(0xFF343442),
    500: Color(0xFF343442),
    600: Color(0xFF343442),
    700: Color(0xFF343442),
    800: Color(0xFF343442),
    900: Color(0xFF343442),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Colors.white,
              ),
              title: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: primaryColorShades,
      ),
      home: CustomAnimatedDrawerScreen(),
    );
  }
}
