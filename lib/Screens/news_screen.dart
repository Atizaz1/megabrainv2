import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:megabrainv2/constants/light_color.dart';
import 'package:megabrainv2/models/News.dart';

class NewsScreen extends StatefulWidget 
{
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> 
{
  @override
  void initState()
  {
    super.initState();
    fetchNewsList();
  }
  
  List<News> newsList;

  bool _isLoading = false;

  var subjectResponse;
  
  var jsonSubjectData;

  List<News> newsFromJson(String str) 
  {
    return List<News>.from(convert.jsonDecode(str).map((x) => News.fromJson(x)));
  }

  String newsToJson(List<News> data) 
  {
    return convert.jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));
  }

  var newsResponse;

  var jsonNewsData;

  fetchNewsList() async 
  {
    setState(() 
    {
      _isLoading = true;
    });


    newsResponse = await http.get("http://megabrain-enem.com.br/API/api/getNOrderedNews");

    jsonNewsData = convert.jsonDecode(newsResponse.body);

    if(newsResponse.statusCode == 200)
    {

      setState(() 
      {
        _isLoading = false;
      });

      print(jsonNewsData);

      newsList = newsFromJson(newsResponse.body);

      print(newsList);

    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
      
      print(newsResponse);
                                        
    }
  }

  var dateFormatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        backgroundColor: LightColor.purple,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () 
              {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text('News',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.white)),
            centerTitle: true,
          ),
        body: Column(
                  children:<Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                  height: MediaQuery.of(context).size.height - 82.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent),
              Positioned(
                  top: 30.0,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.0),
                            // topRight: Radius.circular(45.0),
                          ),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height - 100.0,
                      width: MediaQuery.of(context).size.width)),
                      Positioned(
                  top: 60.0,
                  left: 25.0,
                  right: 25.0,
                  child: Container(
                    height:MediaQuery.of(context).size.height * .7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                        child: Container( 
                      child:_isLoading ? Center(child: CircularProgressIndicator(
                      )): 
                      Center(
                  child: DataTable(columns: [
//                    DataColumn(label: Text('Date',
                    DataColumn(label: Text('DATA',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            )),
//                    DataColumn(label:Text('News',
                    DataColumn(label:Text('NOVIDADE',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ))
                  ], rows: newsList.map(
                      (news) => DataRow(
                        cells: [
                          DataCell(                            
                            Text(dateFormatter.format(news.newsDate),
                                  style: TextStyle(fontSize: 15, color: Colors.black),),
                            onTap: () {
                            },
                          ),
                          DataCell(
                            Text(news.news,
                                  style: TextStyle(fontSize: 15,color: Colors.black),),
                          ),
                        ]),
                      ).toList(),
                  ),
                )
                      ),
                      ),

                      ],
                    ),

                  ),
                    ),

                   ],
                  )  

                  ]
                  )
      ),
    );
  }
}


/*

Center(
                  child: DataTable(columns: [
//                    DataColumn(label: Text('Date',
                    DataColumn(label: Text('DATA',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            )),
//                    DataColumn(label:Text('News',
                    DataColumn(label:Text('NOVIDADE',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ))
                  ], rows: newsList.map(
                      (news) => DataRow(
                        cells: [
                          DataCell(                            
                            Text(dateFormatter.format(news.newsDate),
                                  style: TextStyle(fontSize: 15, color: Colors.black),),
                            onTap: () {
                            },
                          ),
                          DataCell(
                            Text(news.news,
                                  style: TextStyle(fontSize: 15,color: Colors.black),),
                          ),
                        ]),
                      ).toList(),
                  ),
                )
*/

class MenuCard extends StatelessWidget 
{
  const MenuCard({@required this.newsDate, @required this.newsContent});

  final String newsDate;

  final String newsContent;

  @override
  Widget build(BuildContext context) 
  {
    return DataTable(
      columns: [
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('News'))
    ], 
    rows: [
      DataRow(cells: [
        DataCell(Text(newsDate)),
        DataCell(Text(newsContent)),
      ]
    )
    ]
    );
  }
}
