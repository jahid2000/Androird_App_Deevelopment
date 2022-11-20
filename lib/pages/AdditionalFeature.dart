import 'package:flutter/material.dart';

class AdditionalFeatures extends StatefulWidget {
  Map<String,dynamic> response;

  AdditionalFeatures({Key? key, required this.response}) : super(key: key);

  @override
  State<AdditionalFeatures> createState() => _AdditionalFeaturesState();

}

class _AdditionalFeaturesState extends State<AdditionalFeatures> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Latitude: ${widget.response['coord']['lat']}"),
                Text("Longitude: ${widget.response['coord']['lon']}"),
              ]

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("Humidity",
                  style: TextStyle(
                    color: Colors.red,
                  ),

                ),
                Text("${widget.response['main']['humidity']}%"),
              ]

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("Preasure",
                style: TextStyle(
                  color: Colors.red,
                ),
                ),
                Text("${widget.response['wind']['speed']}mmHg")
              ]

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("Visibility",
                style: TextStyle(
                  color: Colors.red,
                ),
                ),
                Text("${widget.response['visibility']/1000.0} km")
              ]

          )
        ],
      ),


    );
  }
}