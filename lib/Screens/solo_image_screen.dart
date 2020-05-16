import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
          child: Scaffold(
          body: Container(
          height: MediaQuery.of(context).size.height / 1,
          child: PhotoView.customChild(
                child: Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: imgLink != null ? CachedNetworkImageProvider(imgLink):
                  AssetImage('assets/images/default_image.jpg'),
                  fit: BoxFit.cover
                ),
              ),
              child: imgLink == null ? Center(
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
              ):
              Container()
            ),
          ),
       ),
      ),
    );
  }
}