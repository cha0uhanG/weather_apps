import 'package:flutter/material.dart';


class WeatherUiScreen extends StatefulWidget {
  final String location;
  final double? temp;

  const WeatherUiScreen({super.key, required this.location, required this.temp});

  @override
  State<WeatherUiScreen> createState() => _UiScreenState();
}

class _UiScreenState extends State<WeatherUiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text("${widget.location},",style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),) ),
          const SizedBox(height: 20,),
          Text("${widget.temp ?? 'unavailable'}\u2103",style: const TextStyle(fontSize: 71,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}