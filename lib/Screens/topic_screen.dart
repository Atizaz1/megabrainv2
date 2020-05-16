import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:megabrainv2/constants/light_color.dart';
import 'package:megabrainv2/models/Topic.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import 'image_screen.dart';

class TopicScreen extends StatefulWidget 
{
  
  final subjectCode;

  final subjectName;

  final area_code;

  final area_name;

  final heroTag;

  TopicScreen({this.subjectCode, this.subjectName, this.area_code, this.area_name, this.heroTag});

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> 
{
  bool _isLoading = false;

  String ss_code;

  String ss_name;

  String area_code;

  String area_name;
  
  List<Topic> topicList;

  var topicResponse;
  
  var jsonTopicData;

  setSubjectAndAreaData(dynamic s_code, dynamic s_name, dynamic a_code, dynamic a_name)
  {
    ss_code   = s_code;

    ss_name   = s_name;
    
    area_code = a_code;

    area_name = a_name;
  }

  @override
  void initState()
  {
    super.initState();
    setSubjectAndAreaData(widget.subjectCode, widget.subjectName, widget.area_code, widget.area_name);
    fetchTopicList();
  }

  List<Topic> topicFromJson(String str) 
  {
    return List<Topic>.from(convert.jsonDecode(str).map((x) => Topic.fromJson(x)));
  }

  String topicToJson(List<Topic> data) 
  {
    return convert.jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));
  }

  fetchTopicList() async 
  {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    setState(() 
    {
      _isLoading = true;
    });

    print(ss_code);

    topicResponse = await http.get("http://megabrain-enem.com.br/API/api/getTopicBySubjectAndAreaCodes/$ss_code/$area_code");

    jsonTopicData = convert.jsonDecode(topicResponse.body);

    if(topicResponse.statusCode == 200)
    {

      setState(() 
      {
        _isLoading = false;
      });

      print(jsonTopicData);

      topicList = topicFromJson(topicResponse.body);

      print(topicList.first.topicName);

    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
      
      print(jsonTopicData);
                                        
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
          child: Scaffold(
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
            title: Text('$ss_name\n$area_name',
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
                            // topLeft: Radius.circular(45.0),
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
                   :(topicList == null || topicList.length == 0) ? Center(child:Text('No Subject Area Topics Found', style: TextStyle(color: Colors.black),))
                      :ListView.separated(
                      itemCount: (topicList == null || topicList.length == 0) ? 0 : topicList.length,
                      itemBuilder: (context, index) 
                      {
                        return InkWell(
                          onTap: () 
                          {
                            Navigator.of(context).push(PageTransition(type: PageTransitionType.size, alignment: Alignment.center, child: ImageScreen(subjectCode: ss_code, subjectName: ss_name,areaCode: area_code,areaName: area_name, topiCode: topicList[index].topicCode.toString(),topicName: topicList[index].topicName)
                            ));
                          },
                          child: ListTile(
                          title: Text(
                            topicList[index].topicName,
                            style: TextStyle(
                              color: int.parse(topicList[index].openTopic) == 0 ? Colors.grey : Colors.black
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