import 'package:flutter/material.dart';
// late TextEditingController _dateController;
void bottomSheet(BuildContext context) {
  late TextEditingController _dateController = TextEditingController();

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
                  controller: _dateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter  datum',
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
                      _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(

                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Mobile Number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter  Number',
                    labelText: ' Number',
                  ),
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
                      String selectedDate = _dateController.text;
                      // int numberOfDays = int.tryParse(daysController.text) ?? 0;

                      print('Selected Date: $selectedDate');
                      // print('Number of Days: $numberOfDays');
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