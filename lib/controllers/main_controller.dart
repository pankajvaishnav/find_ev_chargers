import 'dart:convert';

import 'package:find_chargers/models/locations_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController{
  RxBool isDataLoading = true.obs;

  RxList bookedList = [].obs;
  
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchChargers();
  // }

  Future<LocationResponse> fetchChargers() async{
    late LocationResponse locationResponse;
    try{
      
      var headers = {
        'x-api-key': 'bc9b0d1a5eec5f887cfa7a772d9627f8bca69984bb305a89c4088752e1350d6e'
      };
      var request = http.Request('GET', Uri.parse('https://api-uat.voltnet.io/v0.2.0/omni/cpo/locations/nearby?latitude=13.6521561&longitude=100.6756948&radius=10000&limit=100'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        if (kDebugMode) {
          var resp = jsonDecode(await response.stream.bytesToString());
          locationResponse = LocationResponse.fromJson(resp);
          print(locationResponse.locations.first);
        }
      }
      else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    } 
    return locationResponse;
  }

}