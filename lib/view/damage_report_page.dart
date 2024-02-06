import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/damage_report_controller.dart';
import '../controllers/main_controller.dart';
import '../model/rentals.dart';
import '../widget/menu_bar.dart';

class DamageReportPage extends StatefulWidget {
  const DamageReportPage({Key? key}) : super(key: key);

  @override
  _DamageReportPageState createState() => _DamageReportPageState();
}

class _DamageReportPageState extends State<DamageReportPage> {
  File? _image;
  DamageReportController damageReportController =
  Get.put(DamageReportController());
  MainController mainController = Get.put(MainController());
  String selectedCategory = 'Choose rental';
  int? selectedRentalId;

  @override
  void initState() {
    super.initState();
    getRentals();
  }

  Future<void> getRentals() async {
    await Future.delayed(const Duration(seconds: 0));
    await damageReportController.getRentals();
    setState(() {});
  }

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
        backgroundColor: Colors.black,
        title: Text(
          'Car Damage Report',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: _image == null
                    ? Text(
                  'No image selected.',
                  style: TextStyle(color: Colors.black),textAlign: TextAlign.center
                )
                    : Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: getImage,
                child: Text(
                  'Take a Picture',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(primary: Color(0xffF9B401)),
              ),
              SizedBox(height: 20),
              DropdownButton<int>(
                hint: Text(
                  'Select a rental',
                  style: TextStyle(color: Colors.black),
                ),
                dropdownColor: Color(0xffF9B401),
                value: selectedRentalId,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedRentalId = newValue;
                  });
                },
                items: damageReportController.rentals!
                    .map<DropdownMenuItem<int>>((Rental rental) {
                  return DropdownMenuItem<int>(
                    value: rental.id,
                    child: Text(
                      'Auto: ${rental.car!.brand}, StartDatum: ${rental.fromDate}',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (selectedRentalId != null && _image != null) {
                    damageReportController.makeDamageReport(
                        _image, selectedRentalId!);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/profile', (route) => false);
                  } else {
                    // Handle case where no rental is selected
                    print('Please select a rental');
                  }
                },
                child: Text(
                  'Submit Report',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF9B401),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: mainController.currentIndex.value,
        onTap: mainController.onTabSelected,
      ),
    );
  }
}
