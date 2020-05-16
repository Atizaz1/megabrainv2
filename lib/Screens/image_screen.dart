import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:megabrainv2/Screens/solo_image_screen.dart';
import 'package:megabrainv2/constants/light_color.dart';
import 'package:page_transition/page_transition.dart';
import 'package:megabrainv2/models/Image.dart';

class ImageScreen extends StatefulWidget 
{
  final subjectCode;

  final subjectName;

  final areaCode;

  final areaName;

  final topiCode;

  final topicName;

  ImageScreen({this.subjectCode, this.subjectName, this.areaCode, this.areaName, this.topiCode, this.topicName});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> 
{
  final String linkPrefix = 'http://megabrain-enem.com.br/API/'; 

  String ssCode;

  String ssName;

  String areaCode;

  String areaName;

  String topicCode;

  String topicName;

  setImagePreReq(dynamic ssCode, dynamic ssName, dynamic areaCode, dynamic areaName, dynamic topicCode, dynamic topicName)
  {
    this.ssCode    = ssCode;

    this.ssName    = ssName;
    
    this.areaCode  = areaCode;

    this.areaName  = areaName;

    this.topicCode = topicCode;

    this.topicName = topicName;
  }

  @override
  void initState()
  {
    super.initState();
    setImagePreReq(widget.subjectCode, widget.subjectName, widget.areaCode, widget.areaName, widget.topiCode, widget.topicName);
    fetchImageLinkList();
  }
  
  List<Img> imagesLinkList;

  List<String> tempLinksList = new List<String>();

  bool _isLoading = false;

  var imageResponse;
  
  var jsonImageData;

  List<String> imageLinkFromJson(String str) 
  {
    return List<String>.from(convert.jsonDecode(str).map((x) => x));
  }

  String imageLinkToJson(List<String> data) 
  {
    return convert.jsonEncode(List<dynamic>.from(data.map((x) => x)));
  }

  List<Img> imageFromJson(String str)
  {
    return List<Img>.from(convert.jsonDecode(str).map((x) => Img.fromJson(x)));
  }

  String imgToJson(List<Img> data)
  {
    return convert.jsonEncode(List<dynamic>.from(data.map((x) => x.toJson())));
  }

  fetchImageLinkList() async 
  {
    setState(() 
    {
      _isLoading = true;
    });

    print('Subject Code: $ssCode');
    print('Area Code: $areaCode');
    print('Topic Code: $topicCode');

    imageResponse = await http.get("http://megabrain-enem.com.br/API/api/getImagePathSubjectWise/$ssCode/$areaCode/$topicCode");

    jsonImageData = convert.jsonDecode(imageResponse.body);

    if(imageResponse.statusCode == 200)
    {

      setState(() 
      {
        _isLoading = false;
      });

      print(jsonImageData);

      imagesLinkList = imageFromJson(imageResponse.body);

      print(imagesLinkList.first);

      loadLargeImages();

//      Fluttertoast.showToast(msg: 'Remember: Long Tap to Save/Delete Images', toastLength: Toast.LENGTH_LONG);
      Fluttertoast.showToast(msg: 'Click on image to view the image in full screen',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.black,
      );


    }
    else
    {
      setState(()
      {
        _isLoading = false;
      });
      
      print(jsonImageData);

//      Fluttertoast.showToast(msg: 'No Images were Found Related to Selected Topic');
      Fluttertoast.showToast(msg: 'Nenhuma imagem disponível!');

    }
  }

  void loadLargeImages()
  {
    if(imagesLinkList.length != 0 && imagesLinkList != null)
    {
      for(int i=0; i< imagesLinkList.length ; i++)
      {
        if(imagesLinkList[i].openImage == '1')
        {
          tempLinksList.add(linkPrefix+imagesLinkList[i].imageName);
        }
      }
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
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical:16.0),
              child: Text('$ssName\n$areaName\n$topicName',
              maxLines: 3,
              softWrap: true,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.white
                      ),
                      ),
            ),
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
//                child: (imagesLinkList == null || imagesLinkList.length == 0) ? Center(child:Text('No Images Here', style: TextStyle(color: Colors.black),)) :
                      child:_isLoading ? Center(child: CircularProgressIndicator(
                      )): (imagesLinkList == null || imagesLinkList.length == 0) ? Center(child:Text('Nenhuma imagem!', style: TextStyle(color: Colors.black),)) :
                      GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.6,
                      ),
                      itemCount: (imagesLinkList == null || imagesLinkList.length == 0) ? 0 : imagesLinkList.length,
                      itemBuilder: (context, index) 
                      {
                          return InkWell(
                            onTap: () 
                            {
                              // loadLargeImages();
                              Navigator.push(context, 
                              PageTransition(type: PageTransitionType.leftToRightWithFade,alignment: Alignment.center, child: SoloImageScreen(imgLink: imagesLinkList[index].openImage == '1' ? linkPrefix+imagesLinkList[index].imageName:null))
                              );
                            },
                            child: CachedNetworkImage(
                              progressIndicatorBuilder: (context, url, downloadProgress) => 
                              Center(child:CircularProgressIndicator(value: downloadProgress.progress)),
                                imageUrl: linkPrefix+imagesLinkList[index].imageName,
                                placeholder: (context, url)        => Center(child:CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                            )
                          );
                      },
                        ),
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