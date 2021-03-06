import 'package:device_preview/device_preview.dart' as dp;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megabrainv2/Screens/news_screen.dart';
import 'package:megabrainv2/Screens/splash_screen.dart';
import 'package:megabrainv2/Screens/subject_screen.dart';

import 'Screens/area_screen.dart';
import 'Screens/image_screen.dart';
import 'Screens/topic_screen.dart';

void main() 
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown])
      // .then((_) => runApp(dp.DevicePreview(enabled:!kReleaseMode,builder:(context) => MyApp())));
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      // locale: dp.DevicePreview.of(context).locale,
      // builder: dp.DevicePreview.appBuilder,
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
        'news_screen'    : (context) => new NewsScreen()
      },
    );
  }
}
