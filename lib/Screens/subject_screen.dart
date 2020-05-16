import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:megabrainv2/Screens/area_screen.dart';
import 'package:megabrainv2/Screens/news_screen.dart';
import 'package:megabrainv2/constants/constants.dart';
import 'package:megabrainv2/constants/light_color.dart';
import 'package:megabrainv2/models/Subject.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class SubjectScreen extends StatefulWidget 
{
  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> 
{
  List<Subject> subjectList = new List<Subject>();

  bool _isLoading = false;
  
  var subjectResponse;
  
  var jsonSubjectData;

  List<Subject> subjectFromJson(String str) 
  {
    return List<Subject>.from(convert.jsonDecode(str).map((x) => Subject.fromJson(x)));
  }

  String subjectToJson(List<Subject> data) 
  {
    return convert.jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));
  }

  fetchSubjectList() async 
  {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    setState(() 
    {
      _isLoading = true;
    });

    subjectResponse = await http.get("http://megabrain-enem.com.br/API/api/subjects");

    jsonSubjectData = convert.jsonDecode(subjectResponse.body);

    if(subjectResponse.statusCode == 200)
    {

      setState(() 
      {
        _isLoading = false;
      });

      print(jsonSubjectData);

      subjectList = subjectFromJson(subjectResponse.body);

      print(subjectList.first.ssName);

    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
      
      print(subjectResponse);
                                        
    }
  }

  @override
  void initState() 
  {
    super.initState();
    fetchSubjectList();
  }

  double width;

  Widget _header(BuildContext context) 
  {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: MediaQuery.of(context).size.height > 700 ? 200 : 180,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.purple,
            image: DecorationImage(
                image: AssetImage("assets/images/homebanner.png"), fit:BoxFit.cover
                ),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(150, LightColor.lightpurple)),
              Positioned(
                  top: 140,
                  left: -45,
                  child: _circularContainer(width * .3, LightColor.darkpurple)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>
                        [
                          SizedBox(height: 60),
                          Text(
                            "MegaBrain",
                            style: kHeadingTextStyle.copyWith(
                              fontFamily:'Montserrat'
                            )
                          ),
                        ],
                      )))
            ],
          ),
          ),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) 
  {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

    Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
          child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[
            _header(context),
            SizedBox(height: MediaQuery.of(context).size.height > 700 ? 30 : 15),
            // _categoryRow("Featured Courses", LightColor.orange, LightColor.orange),
            Expanded(
            child: _isLoading ? 
            Center(child:CircularProgressIndicator()) 
            : 
            (subjectList == null || subjectList.length == 0) ? 
            Center(child:Text('No Subject Areas Found', style: TextStyle(color: Colors.black),))
            :
            StaggeredGridView.countBuilder(
              itemCount: (subjectList == null || subjectList.length == 0) ? 0 : subjectList.length,
              padding: EdgeInsets.all(10),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) 
                {
                  return InkWell(
                    onTap: () async
                      {
                        Navigator.of(context).push(PageTransition(type: PageTransitionType.scale,alignment: Alignment.center,child:
                          AreaScreen(subjectCode: subjectList[index].ssCode.toString(), subjectName: subjectList[index].ssName,heroTag: subjectList[index].ssName == 'BIOLOGIA' ? 'assets/images/biol.png' : 
                            subjectList[index].ssName == 'FÍSICA' ? 'assets/images/physics.png': 
                            subjectList[index].ssName == 'MATEMÁTICA' ? 'assets/images/math.png' : 
                            subjectList[index].ssName == 'QUÍMICA' ? 'assets/images/chem.png' : 'assets/images/course_generic.png' ,)
                        ));
                        print(MediaQuery.of(context).size.height);
                      },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:<Widget>
                      [ Container(
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height > 700 || MediaQuery.of(context).size.height > 640 ? 135 : 115,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(
                              subjectList[index].ssName == 'BIOLOGIA' ? 'assets/images/biol.png' : 
                              subjectList[index].ssName == 'FÍSICA' ? 'assets/images/physics.png': 
                              subjectList[index].ssName == 'MATEMÁTICA' ? 'assets/images/math.png' : 
                              subjectList[index].ssName == 'QUÍMICA' ? 'assets/images/chem.png' : 'assets/images/course_generic.png' , 
                            ),
                            // alignment: Alignment.topCenter
                            fit: BoxFit.fill
                          ),
                        ),
                      ),
                      Text(
                        subjectList[index].ssName,
                        style: kTitleTextStyle,
                      )
                      ]
                    ),               
                  );
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
            Container(
              margin: MediaQuery.of(context).size.height > 700 ? EdgeInsets.symmetric(vertical:40, horizontal: 20) : EdgeInsets.symmetric(vertical:20, horizontal: 10),
              decoration: BoxDecoration(
              color:LightColor.purple,
              borderRadius: BorderRadius.circular(16)
              ),
              width:MediaQuery.of(context).size.width,
              height:50,
              child:InkWell(
                onTap: ()
                {
                  Navigator.of(context).push(PageTransition(type: PageTransitionType.fade,alignment: Alignment.center,child:NewsScreen()
                  )
                  );
                },
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>
                  [
                    Image.asset('assets/images/news.png'),
                    Text('News',style:kTitleTextStyle.copyWith(color:Colors.white)),
                  ]
                )
              )
            )
          ]
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   width = MediaQuery.of(context).size.width;
  //   return Scaffold(
        
  //       body: SingleChildScrollView(
  //           child: Container(
  //         child: Column(
  //           children: <Widget>
  //           [
  //             _header(context),
  //             SizedBox(height: 20),
  //             _featuredRowA(),
  //           ],
  //         ),
  //       )));
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.orangeAccent,
  //     body: ListView(
  //       children: <Widget>[
  //         SizedBox(height: 25.0),
  //         Padding(
  //           padding: EdgeInsets.only(left: 40.0),
  //           child: Row(
  //             children: <Widget>[
  //               Text('MegaBrain',
  //                   style: TextStyle(
  //                       fontFamily: 'Montserrat',
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 25.0)),
  //               SizedBox(width: 10.0),
  //               Text('ENEM',
  //                   style: TextStyle(
  //                       fontFamily: 'Montserrat',
  //                       color: Colors.white,
  //                       fontSize: 25.0))
  //             ],
  //           ),
  //         ),
  //         SizedBox(height: 40.0),
  //         Container(
  //           height: MediaQuery.of(context).size.height - 185.0,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
  //           ),
  //           child: ListView(
  //             primary: false,
  //             padding: EdgeInsets.only(left: 25.0, right: 20.0),
  //             children: <Widget>
  //             [
  //               Padding(
  //                   padding: EdgeInsets.only(top: 45.0),
  //                   child: _isLoading ? Center(child:CircularProgressIndicator()) :Container(
  //                       height: MediaQuery.of(context).size.height - 300.0,
  //                       child:  ListView.builder(
  //                       itemCount: (subjectList == null || subjectList.length == 0) ? 0 : subjectList.length,
  //                       itemBuilder: (BuildContext context, int index) 
  //                       { 
  //                           return _buildCourseItem(
  //                           subjectList[index].ssName == 'BIOLOGIA' ? 'assets/images/biol.jpg' : 
  //                           subjectList[index].ssName == 'FÍSICA' ? 'assets/images/physics.jpg': 
  //                           subjectList[index].ssName == 'MATEMÁTICA' ? 'assets/images/math.jpg' : 
  //                           subjectList[index].ssName == 'QUÍMICA' ? 'assets/images/chem.jpg' : 'assets/images/course_generic.png',
  //                           subjectList[index].ssName
  //                           );
  //                       },
  //                        ),
  //                       ),
  //                       ),
                   
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildCourseItem(String imgPath, String courseName) 
  // {
  //   return Padding(
  //       padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
  //       child: InkWell(
  //         onTap: () 
  //         {
  //           // Navigator.of(context).push(MaterialPageRoute(
  //           //   builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
  //           // ));
  //         },
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>
  //           [
  //             Container(
  //               child: Row(
  //                 children: 
  //                 [
  //                   Hero(
  //                     tag: imgPath,
  //                     child: Image(
  //                       image: AssetImage(imgPath),
  //                       fit: BoxFit.cover,
  //                       height: 75.0,
  //                       width: 75.0
  //                     )
  //                   ),
  //                   SizedBox(width: 10.0),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children:[
  //                       Text(
  //                         courseName,
  //                         style: TextStyle(
  //                           fontFamily: 'Montserrat',
  //                           fontSize: 17.0,
  //                           fontWeight: FontWeight.bold
  //                         )
  //                       ),
  //                     ]
  //                   )
  //                 ]
  //               )
  //             ),
  //           ],
  //         )
  //       ));
  // }
}