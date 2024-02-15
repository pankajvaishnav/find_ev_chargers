import 'dart:async';

import 'package:find_chargers/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:slider_button/slider_button.dart';

import '../controllers/main_controller.dart';
import '../models/locations_model.dart';
import '../widgets/custom_app_bar.dart';

class NearbyChargersScreen extends StatefulWidget {
  const NearbyChargersScreen({ Key? key }) : super(key: key);

  @override
  State<NearbyChargersScreen> createState() => _NearbyChargersScreenState();
}

class _NearbyChargersScreenState extends State<NearbyChargersScreen> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final mc = Get.put(MainController());

  LocationResponse? locationResponse;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setLocationResponse();
    });
  }

  setLocationResponse() async {
    try{
        mc.isDataLoading.value = true;
        await mc.fetchChargers().then((value){
          setState(() {
            locationResponse = value;
          });
        });
      } finally {
        mc.isDataLoading.value = false;
      }
  }

  Future<void> _handleRefresh() async{
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    await mc.fetchChargers();
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(68), 
              child: CustomAppbar(title: "Nearby Chargers", 
        showLeading: true),
      ),
      body: Obx(
          () => mc.isDataLoading.value ?
          const Center(child: CircularProgressIndicator(color: Colors.purple,))
           : LiquidPullToRefresh(
              key: _refreshIndicatorKey,
              onRefresh: _handleRefresh,
              color: Colors.purple.shade900,
              showChildOpacityTransition: false,
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                  
                        return true;
                      },
                      child: ListView.builder(padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                                    itemCount: locationResponse == null ? 0 : locationResponse!.locations.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MapScreen(
                        locationResponse: locationResponse!,
                        lat: double.parse(locationResponse!.locations[index].locationData.coordinates.latitude),
                        lng: double.parse(locationResponse!.locations[index].locationData.coordinates.longitude),
                      ))),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: 
                        // mc.bookedList.contains(locationResponse!.locations[index].location.entityCode) ?
                        // null :
                        const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(-4.0, 4.0),
                            blurRadius: 6,
                            spreadRadius: 0.0,
                                            ),
                                            BoxShadow(
                            color: Colors.black12,
                            offset: Offset(4.0, -4.0),
                            blurRadius: 6,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      // color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("Charger ID: ${locationResponse!.locations[index].locationData.entityCode}",
                                      style: const TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                    ),
                                    Text("Brand: ${locationResponse!.locations[index].locationData.name}",
                                      style: const TextStyle(fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 10,),
                                    const Text("Availability:",
                                      style: TextStyle(fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                    ),
                                    const Text("24/7",
                                      style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/images/charger.png",
                                    height: 60,),
                                    const Text("Est Distance",
                                      style: TextStyle(fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                    ),
                                    Text("${locationResponse!.locations[index].distanceMeters < 1 ? 
                                      locationResponse!.locations[index].distanceMeters.toStringAsFixed(2)
                                      : (locationResponse!.locations[index].distanceMeters/100).toStringAsFixed(2)}"
                                    "${locationResponse!.locations[index].distanceMeters < 1 ? ' Ms' : ' KMs'}",
                                      style: const TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            mc.bookedList.contains(locationResponse!.locations[index].locationData.entityCode) ?
                            MaterialButton(onPressed: (){},
                            minWidth: double.infinity,
                            color: Colors.grey,
                            child: const Text(
                                  "Booked !",
                                  style: TextStyle(
                                      color: Colors.white, 
                                      fontWeight: FontWeight.w600, 
                                      fontSize: 16),
                                ),
                            ) :
                          SliderButton(
                            action: () async{
                              mc.bookedList.add(locationResponse!.locations[index].locationData.entityCode);
                              mc.isDataLoading.value = true;
                              mc.isDataLoading.value = false;
                              return false;
                            },
                            label: const Center(
                              child: Text(
                                "\t\t\tSlide to Book >>",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ),
                              icon: const Center(
                                  child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 40.0,
                                // semanticLabel: 'Text to announce in accessibility modes',
                              )),
                              radius: 10,
                              width: MediaQuery.of(context).size.width - 40,
                              buttonColor: Colors.purple.shade900,
                              backgroundColor: Colors.purple,
                              highlightedColor: Colors.white,
                              baseColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}