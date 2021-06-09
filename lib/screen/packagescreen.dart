import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/model/package.dart';

class PackageScreen extends StatefulWidget {
  final Package package;

  PackageScreen({Key? key, required this.package}) : super(key: key);

  @override
  _PackageScreenState createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  late double screenHeight, screenWidth;
  late SharedPreferences prefs;
  int cartitem = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('GiftBox Collection', style: TextStyle(letterSpacing: 2)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 10),
              ListView.builder(
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(0, 3),
                                color: Colors.black12)
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  'Image',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Package ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Container(
                                      width: 200,
                                      child: Text('Description',
                                          style: TextStyle(fontSize: 13))),
                                  SizedBox(height: 25),
                                  Container(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('RM ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue)),
                                        Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                              child: Text('Add to cart',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15))),
                                        )
                                      ],
                                    ),
                                  ),
                                ])
                          ]));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String titleSub(String title) {
    if (title.length < 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }
}
