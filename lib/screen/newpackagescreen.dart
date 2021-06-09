import 'dart:convert';
import 'dart:io';
import '/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sweetgiftbox/view/mainscreen.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class NewPackageScreen extends StatefulWidget {
  @override
  _NewPackageScreenState createState() => _NewPackageScreenState();
}

class _NewPackageScreenState extends State<NewPackageScreen> {
  late AnimationController controller;
  late FutureProgressDialog pr;
  TextEditingController _packageSetController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _qtyController = new TextEditingController();
  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pink[200],
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (content) => MainScreen()));
                setState(() {});
              }),
          title: Text(
            "ADD PACKAGE",
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              _chooseImage();
            },
            child: new SizedBox(
              width: 180,
              height: 180,
              // ignore: unnecessary_null_comparison
              child: (_image != null)
                  ? Image.file(
                      _image,
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      "https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-camera-512.png",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            child: Text('Click to upload picture'),
          ),
          SizedBox(height: 30),
          TextField(
            controller: _packageSetController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: 'Package (Set)',
                icon: Icon(Icons.collections_bookmark),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32))),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 60, 20, 15),
                labelText: 'Description',
                icon: Icon(Icons.description_rounded),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32))),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: 'Price (RM)',
                icon: Icon(Icons.attach_money_sharp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32))),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: 'Quantity Available',
                icon: Icon(Icons.event_available_sharp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32))),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 8.0, right: 8.0, bottom: 20),
            child: Center(
              child: Container(
                  height: 50,
                  width: 200,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.pink,
                    onPressed: () {
                      _addDialog();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Product",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 10),
                        ]),
                  )),
            ),
          ),
        ],
      )),
    );
  }

  void _chooseImage() {
    final snackBar = SnackBar(
        backgroundColor: Colors.grey[200],
        content: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      //height: 30,
                      //width: 100,
                      child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.grey,
                    onPressed: () {
                      _chooseGallery();
                    },
                    child: Row(children: [
                      Text(
                        "Choose from Gallery",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                    ]),
                  )),
                  Container(
                      // height: 30,
                      //width: 100,
                      child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.grey,
                    onPressed: () {
                      _chooseCamera();
                    },
                    child: Row(children: [
                      Text(
                        "Take a photo",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 10),
                    ]),
                  )),
                ],
              )
            ],
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Image Selected");
      Navigator.push(
          context, MaterialPageRoute(builder: (content) => NewPackageScreen()));
    }
    _cropImage();
  }

  Future<void> _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Image Selected");
      Navigator.push(
          context, MaterialPageRoute(builder: (content) => NewPackageScreen()));
    }
    _cropImage();
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).accentColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  Future<void> _addProduct() async {
    pr = FutureProgressDialog(getFuture());
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(), message: Text('Uploading package')),
    );
    showResultDialog(context, result);

    String packageSet = _packageSetController.text.toString();
    String description = _descriptionController.text.toString();
    int quantity = int.parse(_qtyController.text.toString());
    double price = double.parse(_priceController.text.toString());
    String images = base64Encode(_image.readAsBytesSync());

    http.post(
        Uri.parse(CONFIG.SERVER + "/272932/sweetgiftbox/php/newproduct.php"),
        body: {
          "packageSet": packageSet,
          "description": description,
          "quantity": quantity.toStringAsFixed(1),
          "price": price.toStringAsFixed(2),
          "encoded_string": images,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Successfully added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);

        Navigator.push(
            context, MaterialPageRoute(builder: (content) => MainScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Failed to add",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        return;
      }
    });
  }

  void _addDialog() {
    // ignore: unnecessary_null_comparison
    if (_image == null ||
        _packageSetController.text.toString() == "" ||
        _descriptionController.text.toString() == "" ||
        _priceController.text.toString() == "" ||
        _qtyController.text.toString() == "") {
      Fluttertoast.showToast(
          msg: "Image/Textfield is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.grey[200],
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Confirm to upload"),
            actions: [
              TextButton(
                child: Text("Confirm", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addProduct();
                },
              ),
              TextButton(
                  child: Text("Cancel", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 5));
      return 'Loading...';
    });
  }

  void showResultDialog(BuildContext context, result) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(content: Text(result), actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ]));
  }
}
