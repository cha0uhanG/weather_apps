import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather/weather_bloc.dart';
import 'package:weather_app/presentation/auth/sign_in_screen.dart';
import 'package:weather_app/presentation/weather/weather_ui_screen.dart';
import 'package:weather_app/presentation/widget/alert_message.dart';


class WeatherScreen extends StatefulWidget {
  static const page = "weather";

  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _locationController = TextEditingController();
 // final AP ap = AP();

  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, SigninPage.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey,
      appBar: AppBar(backgroundColor:  Colors.grey[800],
        title: const Center(child: Text('Weather Checker',style: TextStyle(color:Colors.white ))),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout,color: Colors.white,),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/cloudd.jpeg'),
                fit: BoxFit.cover, // This ensures that the image covers the entire container
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 230),
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Enter Location',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black, width: 3.0), // Adjust color and width as needed
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      String location = _locationController.text;
                      if (location.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(message());
                      } else {
                        // dynamic temperature = await ap.testing(location);
                        //  print("The temperature in $location is $temperature");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WeatherUiScreen(location: location, temp: 27.0),),
                        );
                      }
                    },
                    child: const Text('Get Weather'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
