import 'dart:async';
import 'package:flutter/material.dart';
import 'package:megabrainv2/Screens/subject_screen.dart';
import 'package:megabrainv2/constants/light_color.dart';
import 'package:page_transition/page_transition.dart';
 
 class SplashScreen extends StatefulWidget 
 {
    @override                         
    State<StatefulWidget> createState() 
    {
      return SplashState();
    }
  }

class SplashState extends State<SplashScreen> 
{

  startTime() async 
  {
    var duration = new Duration(seconds: 8);
    return new Timer(duration, route);
  }

  @override
  void initState() 
  {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: initScreen(context),
    );
  }

  route() 
  {
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade,child:SubjectScreen())
    ); 
  }

  initScreen(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset("assets/images/applogo.png", scale: 2.5),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                "megaBrain ENEM",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white
                ),
              ),

              Text(
                " ",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white
                ),
              ),

              Center( child: Text(
                'BIOLOGIA      |   FÍSICA',
                style: TextStyle(
                  fontSize: 20.0,
                  color: LightColor.purple,
                ),
              ),
              ),
              Text(
                'MATEMÁTICA   |   QUÍMICA',
                style: TextStyle(
                  fontSize: 20.0,
                  color: LightColor.purple,
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 20.0)),
//            CircularProgressIndicator(
//              backgroundColor: Colors.white,
//              strokeWidth: 1,
//           ),
              Container(
                child: Image.asset("assets/images/loading.gif", scale: 3),
              ),
           ],
         ),
        ),
      ),
    );
  }
}