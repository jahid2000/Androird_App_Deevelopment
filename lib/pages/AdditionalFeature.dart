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
                Text("Longitude: ${widget.response['coord']['lon']}"),
                Text("Latitude: ${widget.response['coord']['lat']}"),
              ]

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("আর্দ্রতা:"),
                Text("${widget.response['main']['humidity']}%"),
              ]

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("বায়ু-চাপ:"),
                Text("${widget.response['wind']['speed']}mmHg")
              ]

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text("দৃষ্টিসীমা:"),
                Text("${widget.response['visibility']/1000.0} km")
              ]

          )
        ],
      ),


    );
  }
}