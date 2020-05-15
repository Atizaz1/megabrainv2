import 'package:flutter/material.dart';
import 'package:megabrainv2/Screens/splash_screen.dart';
import 'package:megabrainv2/Screens/subject_screen.dart';

import 'Screens/area_screen.dart';
import 'Screens/image_screen.dart';
import 'Screens/topic_screen.dart';

void main() 
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      title: 'MegaBrain ENEM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'splash_screen',
      routes: 
      {
        'splash_screen'  : (context) => new SplashScreen(),
        'subject_screen' : (context) => new SubjectScreen(),
        'area_screen'    : (context) => new AreaScreen(),
        'topic_screen'   : (context) => new TopicScreen(),
        'image_screen'   : (context) => new ImageScreen(),
      },
    );
  }
}
