import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';


class GetLocationData{
  static Future<Map<String,dynamic>>getResponseForCurrentLocation()async{
    LocationPermission locationPermission=await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied){
      locationPermission=await Geolocator.requestPermission();
    }
    Position position =await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    var longitude=position.longitude.toStringAsFixed(2);
    var latitude=position.latitude.toStringAsFixed(2);
    final queryParameter={
      "lon":longitude,
      "lat":latitude,
      "appid":"9a8aecb6395eb0eb807191d06386c3a9"
    };
    final uri=Uri.http("api.openweathermap.org", "/data/2.5/weather",queryParameter);
    final response=await get(uri);
    final data=jsonDecode(response.body)as Map<String,dynamic>;
    return data;
  }
}