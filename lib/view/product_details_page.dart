import 'package:flutter/material.dart';
import 'package:mobileappdev/viewmodel/car_viewmodel.dart';

class ProductDetailsPage extends StatelessWidget {
  final CarViewModel car;

  ProductDetailsPage({
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Image.network(
                    car.img,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: 20), // Additional padding at the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.brand,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xffF9B401),
                          ),
                        ),
                        Text(
                          car.model,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '€  ${car.price} per dag' ,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Features",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xb3ffffff),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ResponsiveSquareContainer(
                        icon: Icons.event_seat_outlined,
                        label: "SEATS",
                        value:  (car.nrOfSeats).toString()
                      ),
                    ),
                    SizedBox(width: 10),
                    const Expanded(
                      child: ResponsiveSquareContainer(
                          icon: Icons.speed,
                          label: "SPEED",
                          value: "200 km/h"
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ResponsiveSquareContainer(
                          icon: Icons.access_time_sharp,
                          label: "YEAR",
                          value: (car.modelYear).toString()
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ResponsiveSquareContainer(
                          icon: Icons.local_gas_station,
                          label: "FUEl",
                          value: car.fuel
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ResponsiveSquareContainer(
                          icon: Icons.filter_list_rounded,
                          label: "OPTIONS",
                          value: car.options
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ResponsiveSquareContainer(
                          icon: Icons.power,
                          label: "ENGINE SIZE",
                          value: (car.engineSize).toString()
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                      backgroundColor: const Color(0xffF9B401)
                  ),
                  onPressed: () { },
                  child:const Text("Reservation"),
                ),
                )
              ],

            ),
          )
        ],
      )

    );
  }
}

// Custom widget for a responsive square container
class ResponsiveSquareContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ResponsiveSquareContainer({super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff171a1f),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Icon(
                icon,
                color: Colors.white,
                size: 30.0,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xb3ffffff),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}