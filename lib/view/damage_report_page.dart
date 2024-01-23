import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../viewmodel/damage_report_controller.dart';

class DamageReportPage extends StatefulWidget {
  const DamageReportPage({super.key});
  @override
  _DamageReportPageState createState() => _DamageReportPageState();
}

class _DamageReportPageState extends State<DamageReportPage> {
  File? _image;

  DamageReportController damageReportController =  Get.put(DamageReportController());
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Car Damage Report',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              child: _image == null
                  ? Text(
                'No image selected.',
                style: TextStyle(color: Colors.white),
              )
                  : Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Take a Picture', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(primary: Colors.yellow),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                damageReportController.makeDamageReport(_image);
              },
              child: Text('Submit Report', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(primary: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }

}
