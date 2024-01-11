import 'package:flutter/material.dart';
import '../model/car.dart';
import '../viewmodel/reservation_controller.dart';
// late TextEditingController _dateController;
void bottomSheet(BuildContext context, Car car) {
  late TextEditingController _toDateController = TextEditingController();
  late TextEditingController _fromDateController = TextEditingController();
  ReservationController _reservationController = ReservationController();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Reserveer nu',
                  style:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _fromDateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter bezorg datum',
                    labelText: ' Datum',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null ) {
                      _fromDateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _toDateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter ophaal datum',
                    labelText: ' Datum',
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null ) {
                      _toDateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                  Align(
                    alignment: Alignment.bottomRight, child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffF9B401)
                    ),
                    onPressed: () {
                      String fromDate = _fromDateController.text;
                      String toDate = _toDateController.text;

                      _reservationController.makeReservation(fromDate, toDate, car);
                      print('Selected to Date: $toDate');
                      print('Selected from Date:  $fromDate');
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Reserveer',
                    ),
                  ),
                  ),

              ],
            ),
          ),
        ),
      );
    },
  );
}