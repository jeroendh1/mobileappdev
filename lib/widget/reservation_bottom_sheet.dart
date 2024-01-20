import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/car.dart';
import '../viewmodel/reservation_controller.dart';

void bottomSheet(BuildContext context, Car car) {
  late TextEditingController _toDateController = TextEditingController();
  late TextEditingController _fromDateController = TextEditingController();
  late TextEditingController _streetController = TextEditingController();
  late TextEditingController _postcodeController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();

  ReservationController _reservationController = ReservationController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Reserveer nu',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _fromDateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter bezorg datum',
                      labelText: 'Bezorg datum',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _fromDateController.text =
                        pickedDate.toLocal().toString().split(' ')[0];
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul a.u.b. de bezorgdatum in';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _toDateController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter ophaal datum',
                      labelText: 'Ophaal datum',
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _toDateController.text =
                        pickedDate.toLocal().toString().split(' ')[0];
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul a.u.b. de ophaaldatum in';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter straat & huisnummer',
                      labelText: 'Straat & Huisnummer',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul straat & huisnummer in';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _postcodeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter postcode',
                      labelText: 'Postcode',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul uw postcode in';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter woonplaats',
                      labelText: 'Woonplaats',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul uw woonplaats in';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffF9B401),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String fromDate = _fromDateController.text;
                          String toDate = _toDateController.text;
                          String address = '${_streetController.text}, ${_postcodeController.text} ${_cityController.text}';
                          var reservation = await _reservationController.makeReservation(fromDate, toDate, address, car);

                          if ( reservation == true) {
                            Fluttertoast.showToast(
                                msg: "Auto is gereserveerd",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(
                                msg: reservation,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      },
                      child: Text('Reserveer'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}