import 'dart:convert';
import 'package:flutter/material.dart';
import  'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MaterialApp(

    home:Home(),

  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
var bannerItem =["hair","Shave","Facial"];
var bannerImage=[
  "images/haircut.jpg",
  "images/shave.jpg",
  "images/massage.jpg",


];
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;
    Future <List<Widget>> createList() async{
      List<Widget> items=new List<Widget>();
      String dataString= await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJson =jsonDecode(dataString);



      String finalString="";
      dataJson.forEach((object) {
        List<dynamic> dataList=object["placeItems"];
        dataList.forEach((item) {
          finalString=finalString+item+"|";

        });


        items.add(Padding(
            padding: EdgeInsets.all(1.0),
            child: Container(
              margin: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(05.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                  ),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    child: Image.asset(
                        object["placeImage"],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),


                  ),
               SizedBox(
                 width: 250,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child:  Column(


                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>
                       [
                         Text(
                             object["placeName"],
                             style: TextStyle(
                               fontSize: 15,

                               fontWeight: FontWeight.bold,
                               color: Colors.blue

                           ),
                         ),

                               Padding(
                                 padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                                 child: Text(
                                 finalString,
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,

                                 style: TextStyle(
                                   fontSize: 14.0,
                                   letterSpacing: 1.5,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.blueGrey,

                           ),
                            ),
                               ),
                         FlutterRatingBar(
                            initialRating: 3,
                           fillColor: Colors.amber,
                           borderColor: Colors.amber.withAlpha(40),
                           allowHalfRating: true,

                         ),
                       ],
                   ),
                 ),
               ),


                ],
              ),
            ),
        ));
      });
      return items;
    }
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 5, 0, 0), //tiltle bar padding

                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   IconButton(
                     icon: Icon(
                         Icons.menu
                     ),
                     onPressed: (){},
                   ),
                   Text('Saloon',

                     style: TextStyle(
                       fontSize: 50.0,
                     ),
                   ),
                   IconButton(icon: Icon(Icons.person),onPressed: (){},),
                 ],
                 ),
               ),
                BannerWidgetArea(),//calling slider
                Container(

                  child: FutureBuilder(
                    initialData: <Widget> [Text(" wait")],
                      future: createList(),
                      builder:(context,snapshot){
                      if(snapshot.hasData){
                        return Padding(
                          padding: EdgeInsets.all(3.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data,

                          ),
                        );
                      }else{
                          return Center(child: CircularProgressIndicator());

                      }
                      }),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class BannerWidgetArea extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    var screenWidth=MediaQuery.of(context).size.width;

    PageController controller = PageController(viewportFraction: 0.8 ,initialPage: 1);
    List<Widget>banners=new List<Widget>();
    for(int x=0;x<bannerItem.length;x++){
      var bannerView= Padding(padding: EdgeInsets.all(8.0),//gap bw image
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(//behind the image that's why we create this before clipreact
                      color:Colors.black12,
                      offset: Offset(1.0,1.0),
                      spreadRadius:0.0,
                      blurRadius: 1.0
                  ),
                ],
              ),

            ),
            ClipRRect(//for curving the image
              borderRadius: BorderRadius.all(Radius.circular(200.0),
              ),
                child: Image.asset(
                  bannerImage[x],
                  fit: BoxFit.fitWidth,
                ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gradient:LinearGradient(
                  begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent,Colors.black12]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  Text(
                    bannerItem[x],
                    style: TextStyle(
                      fontSize: 35.0,
                    color: Colors.amber,
                    ),
                  ),
                  Text(
                    "more than 40% off" ,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

       ),
      );

          banners.add(bannerView);
    }
    return Container(
     height: screenHeight-250,
      width: screenWidth*16/9,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
        child: PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: banners,
        ),
      ),

    );
  }
}
