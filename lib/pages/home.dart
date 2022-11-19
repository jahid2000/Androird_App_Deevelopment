import 'dart:async';
import 'dart:convert';
//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_weather/pages/Timeinterval.dart';
import 'package:app_weather/pages/AdditionalFeature.dart';

import 'GetLocationData.dart';


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static Map<String,dynamic> getSample(){
    return {"coord": {"lon": 88.6367, "lat": 24.3704}, "weather": [{"id": 803, "main": "Clouds", "description": "broken clouds", "icon": "04d"}], "base": "stations", "main": {"temp": 300.74, "feels_like": 300.35, "temp_min": 300.74, "temp_max": 300.74, "pressure": 1010, "humidity": 38, "sea_level": 1010, "grnd_level": 1008}, "visibility": 10000, "wind": {"speed": 3.98, "deg": 348, "gust": 3.99}, "clouds": {"all": 76}, "dt": 1668850387, "sys": {"country": "BD", "sunrise": 1668817421, "sunset": 1668856687}, "timezone": 21600, "id": 1185128, "name": "Rajshahi", "cod": 200};
  }

  Map<String, dynamic> res = getSample();
  Widget AditionalFeatures=Text("loading");
  var temp,description, currently, humidity, windSpeed;
  var location = "Rajshahi";
  final TextEditingController textEditingController = TextEditingController();
  //var date = DateTime.now().toString();
   var dateUpdate = Timeinterval();
  var date = "current date",currentTime = "current time";
 void setDate(){
   setState(() {
      date=dateUpdate.getCurrentDate();
   });
 }
 void setTime(){
   setState(() {
     currentTime=dateUpdate.getCurrentTime();
   });
 }

  Future getData() async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Rajshahi&units=metric&appid=9a8aecb6395eb0eb807191d06386c3a9"));
    var results = jsonDecode(response.body);
    print(results);
    setState(() {
      temp = (results['main']['temp']).toStringAsFixed(2);
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      res = results;
    });

  }

  Future getDataWithCity(String city) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=9a8aecb6395eb0eb807191d06386c3a9"));
    var results = jsonDecode(response.body);
    setState(() {
      temp = (results['main']['temp']).toStringAsFixed(2);
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.location = city;
      res = results;
    });
  }
    void getDataWithLL() async {
   print("int the function of get location data");
     // http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=9a8aecb6395eb0eb807191d06386c3a9"));
      var results = await GetLocationData.getResponseForCurrentLocation();
      setState(() {
        temp = (results['main']['temp']).toStringAsFixed(2);
        this.description = results['weather'][0]['description'];
        this.currently = results['weather'][0]['main'];
        this.humidity = results['main']['humidity'];
        this.windSpeed = results['wind']['speed'];
        this.location = results['name'];
        res = results;
      });

  }
 void setTimer(){
   Timer.periodic(
     const Duration(seconds: 1),(timer){
       setTime();
       setDate();
   }

   );
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setTimer();
    getDataWithLL();
    //startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text('Weather App'),

          ),
          body: Column(
            children: <Widget>[
                Container(
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[

                      Text(
                      "Weather at $location",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize:15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:<Widget>[

                        Text(

                          temp!=null?temp+"\u00B0C":"temperature is loading...",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize:18.0,
                            fontWeight: FontWeight.w800,

                          ),
                        ),
                          Text(
                            temp!=null?(double.parse(temp)*1.8+32).toString()+"\u00B0F":"temperature is loading",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize:18.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ],
                      ),

                    // Text(date),
                      Text(
                        date,
                      ),
                     Text(
                       currentTime,
                     ),

                     Text (
                      currently!=null ? currently.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                       TextField(
                        textAlign: TextAlign.center,
                         controller: textEditingController,
                      ),

                      TextButton(onPressed: () {
                        getDataWithCity(textEditingController.text);
                      }, child: const Text("Search")),
                      TextButton(onPressed:(){ getDataWithLL();}, child: const Text("get current location")),
                      Text(
                      "view weather",
                  style: TextStyle(
              color: Colors.green,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,

             ),
                   ),
                      AdditionalFeatures(response: res),
                    ],
                ),
                ),
            ],
    ),
        ),
    );
  }
}

