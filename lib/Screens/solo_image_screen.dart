import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:store_redirect/store_redirect.dart';

class SoloImageScreen extends StatefulWidget 
{
  final imgLink;

  SoloImageScreen({@required this.imgLink});

  @override
  _SoloImageScreenState createState() => _SoloImageScreenState();
}

class _SoloImageScreenState extends State<SoloImageScreen> 
{
  String imgLink;

  setImageLink(dynamic link)
  {
    imgLink = link;
    imgLink != null ? Fluttertoast.showToast(msg: 'Click on image to Zoom in or Zoom out.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.amberAccent,
    textColor: Colors.black,
    ):null;
  }

  @override
  void initState()
  {
    super.initState();
    setImageLink(widget.imgLink);
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
    body: Container(
    height: MediaQuery.of(context).size.height / 1,
    child: PhotoView.customChild(
          child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: imgLink != null ? CachedNetworkImageProvider(imgLink):
            AssetImage('assets/images/default_image.jpg'),
            fit: BoxFit.contain
          ),
        ),
        child: imgLink == null ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:80),
            Center(
              // heightFactor: 20,
              child: Container(
                // margin: EdgeInsets.all(20),
                child:InkWell(
                onTap:()
                {
                  print('Hello');
                  StoreRedirect.redirect(
                        androidAppId: "com.monday.monday",
                        iOSAppId: "1290128888");
                },
                child: Container(
                  width: 230,
                  height: 230,
                  decoration:BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/playstore2.png'),
                      fit:BoxFit.contain
                      )
                  ),
                  ),
                  ),
              ),
            ),
          ],
        ):
        Container()
      ),
    ),
       ),
      );
  }
}