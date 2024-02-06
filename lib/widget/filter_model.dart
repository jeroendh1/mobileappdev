import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class FilterModalBottomSheet extends StatefulWidget {
  @override
  _FilterModalBottomSheetState createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  int _startYear = 2019;
  int _endYear = 2023;
  String _selectedFuelType = 'All';
  String _selectedBody = 'All';
  final List<String> _fuelTypes = ['All','Gasoline', 'Diesel', 'Hybrid', 'Electric'];
  final List<String> _bodyOptions = [
    'All',
    'STATIONWAGON',
    'SEDAN',
    'HATCHBACK',
    'MINIVAN',
    'MPV',
    'SUV',
    'COUPE',
    'TRUCK',
    'CONVERTIBLE'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildHeader(),
            const SizedBox(height: 10),
            _buildYearSlider(),
            const SizedBox(height: 10),
            _buildFuelTypeDropdown(),
            const SizedBox(height: 10),
            _buildBodyDropdown(),
            const SizedBox(height: 10),
            _buildApplyFiltersButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Filter Cars",
          style: TextStyle(

            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Spacer(),
        IconButton(
          icon: const Icon(
            Icons.cancel,
            color: Color(0xffF9B401),
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _buildYearSlider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Bouwjaar:",
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          "$_startYear - $_endYear",
          style: const TextStyle(
            color: Color(0xffF9B401),
          ),
        ),
        RangeSlider(
          activeColor: Color(0xffF9B401),
          values: RangeValues(
            _startYear.toDouble(),
            _endYear.toDouble(),
          ),
          min: 2019,
          max: 2023,
          onChanged: (RangeValues values) {
            setState(() {
              _startYear = values.start.toInt();
              _endYear = values.end.toInt();
            });
          },
        ),
      ],
    );
  }

  Widget _buildFuelTypeDropdown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Selecteer brandstof type",
          style: TextStyle(color: Colors.grey),
        ),
        DropdownButton<String>(
          style: const TextStyle(
            color: Color(0xffF9B401),
          ),
          value: _selectedFuelType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedFuelType = newValue!;
            });
          },
          items: _fuelTypes.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildBodyDropdown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Selecteer body",
          style: TextStyle(color: Colors.grey),
        ),
        DropdownButton<String>(
          style: const TextStyle(
            color: Color(0xffF9B401),
          ),
          value: _selectedBody,
          onChanged: (String? newValue) {
            setState(() {
              _selectedBody = newValue!;
            });
          },
          items: _bodyOptions.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildApplyFiltersButton() {
    return ElevatedButton(
      child: Text('Apply Filters'),
      style: ElevatedButton.styleFrom(
        primary: Color(0xffF9B401),
        onPrimary: Colors.white,
      ),
      onPressed: () {
        HomeViewModel carListController = Get.find<HomeViewModel>();
        carListController.filterCars(
          _startYear,
          _endYear,
          _selectedFuelType,
          _selectedBody,
        );
        Navigator.of(context).pop();
      },
    );
  }
}
