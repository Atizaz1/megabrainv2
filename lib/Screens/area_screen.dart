import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:megabrainv2/Screens/topic_screen.dart';
import 'package:megabrainv2/constants/light_color.dart';
import 'package:megabrainv2/models/Area.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class AreaScreen extends StatefulWidget 
{
  final subjectCode;
  final subjectName;
  final heroTag;

  AreaScreen({this.subjectCode, this.subjectName, this.heroTag});

  @override
  _AreaScreenState createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> 
{
  String ss_code;

  String ss_name;

  String heroTag;

  setSubjectData(dynamic code, dynamic name, dynamic tag)
  {
    this.ss_code = code;
    this.ss_name = name;
    this.heroTag = tag;
  }

  @override
  void initState()
  {
    super.initState();
    setSubjectData(widget.subjectCode, widget.subjectName, widget.heroTag);
    fetchAreaList();
  }
  
  List<Area> areaList;

  bool _isLoading = false;

  var areaResponse;
  
  var jsonAreaData;

  List<Area> areaFromJson(String str) 
  {
    return List<Area>.from(convert.jsonDecode(str).map((x) => Area.fromJson(x)));
  }

  String areaToJson(List<Area> data) 
  {
    return convert.jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));
  }

  fetchAreaList() async 
  {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    setState(() 
    {
      _isLoading = true;
    });

    print(ss_code);

    areaResponse = await http.get("http://megabrain-enem.com.br/API/api/getAreasListBySubjectCode/$ss_code");

    jsonAreaData = convert.jsonDecode(areaResponse.body);

    if(areaResponse.statusCode == 200)
    {

      setState(() 
      {
        _isLoading = false;
      });

      print(jsonAreaData);

      areaList = areaFromJson(areaResponse.body);

      print(areaList.first.areaName);

    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
      
      print(jsonAreaData);
                                        
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height / 1,
//         child: Column(
//           children: <Widget>[
//             Expanded(
//                           child: Container(
//                   child: _isLoading ? Center(child: CircularProgressIndicator(
//                     // backgroundColor: Colors.orange[500],
//                   ))
// //                  :(areaList == null || areaList.length == 0) ? Center(child:Text('No Subject Areas Found', style: TextStyle(color: Colors.black),))
//                       :(areaList == null || areaList.length == 0) ? Center(child:Text('Nenhuma área encontrada', style: TextStyle(color: Colors.black),))
//                   :ListView.separated(
//                   itemCount: (areaList == null || areaList.length == 0) ? 0 : areaList.length,
//                   itemBuilder: (context, index) 
//                   {
//                     return GestureDetector(
//                       onTap: () 
//                       {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) {
//                         //   return TopicScreen(subjectCode: ss_code,subjectName: ss_name,area_code: areaList[index].areaCode.toString(),area_name: areaList[index].areaName);
//                         // }));
//                       },
//                       child: ListTile(
//                       title: Text(
//                         areaList[index].areaName,
//                         style: TextStyle(
//                           color: Colors.black
//                         ),
//                       ),
//                       trailing: Icon(Icons.keyboard_arrow_right,
//                       color:Colors.black
//                       ),
//                         ),
//                     );
//                   }, separatorBuilder: (BuildContext context, int index) 
//                   {
//                       return Divider(thickness: 1,color:Colors.grey[500]);
//                   }, 
//                   ),
//                 ),
//             ),
//           ],
//         ),
//       ),
backgroundColor: LightColor.purple,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('$ss_name',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
          ),
          body:Column(children: [
            Stack(children: [
              Container(
                  height: MediaQuery.of(context).size.height - 82.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent),
              Positioned(
                  top: 75.0,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height - 100.0,
                      width: MediaQuery.of(context).size.width)),
              Positioned(
                  top: 0.0,
                  left: (MediaQuery.of(context).size.width / 2) - 100.0,
                  child: Hero(
                  tag: widget.heroTag,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: AssetImage(widget.heroTag),
                              fit: BoxFit.cover)),
                      height: 200.0,
                      width: 200.0))),
              Positioned(
                  top: 220.0,
                  left: 25.0,
                  right: 25.0,
                  child: Container(
                    height:MediaQuery.of(context).size.height * .5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Expanded(
                      child: Container(
                      child: _isLoading ? Center(child: CircularProgressIndicator(
                      ))
//                  :(areaList == null || areaList.length == 0) ? Center(child:Text('No Subject Areas Found', style: TextStyle(color: Colors.black),))
                          :(areaList == null || areaList.length == 0) ? Center(child:Text('Nenhuma área encontrada', style: TextStyle(color: Colors.black),))
                      :ListView.separated(
                      itemCount: (areaList == null || areaList.length == 0) ? 0 : areaList.length,
                      itemBuilder: (context, index) 
                      {
                        return InkWell(
                          onTap: () 
                          {
                            print(widget.heroTag);
                            Navigator.of(context).push(PageTransition(type: PageTransitionType.size, alignment: Alignment.center, child: TopicScreen(subjectCode: ss_code,subjectName: ss_name,area_code: areaList[index].areaCode.toString(),area_name: areaList[index].areaName,heroTag: widget.heroTag,)
                            ));
                          },
                          child: ListTile(
                          title: Text(
                            areaList[index].areaName,
                            style: TextStyle(
                              color: int.parse(areaList[index].openArea) == 0 ? Colors.grey : Colors.black
                            ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right,
                          color:Colors.black
                          ),
                            ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) 
                      {
                          return Divider(thickness: 0,height:0,color:Colors.grey[500]);
                      }, 
                      ),
                    ),
              ),
                      ]
                    ),
                  ),
                                ),
                    ]
            ),
                  ]
                  )
      ),
    );
  }
}