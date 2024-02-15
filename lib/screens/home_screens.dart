import 'package:find_chargers/screens/nearby_chargers.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(68), 
      //         child: CustomAppbar(title: "Charger Reservation", 
      //   showLeading: false),
      // ),
      body: SingleChildScrollView(
                        child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Center(
                    child: Image.asset("assets/images/electric-car.png",
                    height: 100,),
                  ),
                  const Center(
                    child: Text(
                      "Charger Reservation",
                      style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w700, 
                      fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  const Text(
                    "EV Number:",
                    style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w700, 
                    fontSize: 16),
                  ),
                  const SizedBox(height: 4,),
                  const Row(
                    children: [
                      Expanded(flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current SOC",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w400, 
                              fontSize: 14),
                            ),
                            Text(
                              "76%",
                              style: TextStyle(color: Colors.green,
                              fontWeight: FontWeight.w600, 
                              fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current SOH",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w400, 
                              fontSize: 14),
                            ),
                            Text(
                              "75.5%",
                              style: TextStyle(color: Colors.green,
                              fontWeight: FontWeight.w600, 
                              fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  const Row(
                    children: [
                      Expanded(flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Voltage",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w400, 
                              fontSize: 14),
                            ),
                            Text(
                              "59.56",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w600, 
                              fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Temperature",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w400, 
                              fontSize: 14),
                            ),
                            Text(
                              "75.5%",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w600, 
                              fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),
                  const Row(
                    children: [
                      Expanded(flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Predicted Kwh/Km",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w400, 
                              fontSize: 14),
                            ),
                            Text(
                              "120 Kwh/Km",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w600, 
                              fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Predicted Kwh/Km",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w400, 
                              fontSize: 14),
                            ),
                            Text(
                              "110 Kwh/Km",
                              style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w600, 
                              fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      "Use the slider at the bottom to search for nearby chargers and confirm your booking. "
                      "Once booked, you can use this mobile application to navigate to the charging station "
                      "and initiate or stop charging.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.w400, 
                      fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  SliderButton(
                    action: () async{
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const NearbyChargersScreen()));
                      return false;
                    },
                    width: MediaQuery.of(context).size.width - 40,
                    label: const Text(
                      "Slide to Search Chargers",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    icon: const Center(
                        child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 40.0,
                    )),
                    radius: 10,
                    buttonColor: Colors.purple.shade900,
                    backgroundColor: Colors.purple,
                    highlightedColor: Colors.white,
                    baseColor: Colors.grey,
                  ),
                const SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      
    );
  }
}
