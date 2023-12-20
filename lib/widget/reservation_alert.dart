import 'package:flutter/material.dart';

class DateAndDaysInputAlert extends StatefulWidget {
  @override
  _DateAndDaysInputAlertState createState() => _DateAndDaysInputAlertState();
}

class _DateAndDaysInputAlertState extends State<DateAndDaysInputAlert> {
  late TextEditingController dateController;
  late TextEditingController daysController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController();
    daysController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  const Text('Reserveer'),
      backgroundColor: Color(0xffF9B401),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: dateController,
            decoration: InputDecoration(labelText: 'Datum'),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != DateTime.now()) {
                dateController.text = pickedDate.toLocal().toString().split(' ')[0];
              }
            },
          ),
          SizedBox(height: 15),
          TextField(
            controller: daysController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Aantal dagen'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert
          },
          child: Text('X'),
        ),
        ElevatedButton(
          onPressed: () {
            // Perform action with the entered data
            String selectedDate = dateController.text;
            int numberOfDays = int.tryParse(daysController.text) ?? 0;
            // You can use the selectedDate and numberOfDays as needed
            print('Selected Date: $selectedDate');
            print('Number of Days: $numberOfDays');
            Navigator.of(context).pop(); // Close the alert
          },
          child: const Text('Reserveer'),
        ),
      ],
    );
  }
}