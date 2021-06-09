import 'package:flutter/material.dart';
import 'package:sweetgiftbox/screen/newpackagescreen.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double screenWidth;
  late double screenHeight;
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
      ),
      floatingActionButton: Visibility(
        visible: _visible,
        child: FloatingActionButton.extended(
            label: Text('ADD PRODUCT'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.pink,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (content) => NewPackageScreen()),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

