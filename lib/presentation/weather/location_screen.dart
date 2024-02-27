import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/application/weather/weather_bloc.dart';
import 'package:weather_app/domain/weather/model.dart';
import 'package:weather_app/preference.dart';
import 'package:weather_app/presentation/auth/sign_in_screen.dart';
import 'package:weather_app/presentation/weather/weather_screen.dart';

class LocationPage extends StatefulWidget {
  static const page = "LocationPage";

  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // BP bp = BP();

  //Controller controller = Get.put(Controller());

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, SigninPage.page);
  }

  @override
  void initState() {
    //  controller.tempp.value = MyPref().temp.val;
    //  controller.citynamee.value = MyPref().stateName.val;
    //  controller.humid.value = MyPref().humidity.val;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Center(
            child: Text(
          'Weather',
          style: TextStyle(color: Colors.white),
        )),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocConsumer<WeatherBloc, WeatherBlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is WeatherResponseState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    '  ${state.data.cityName}, ',
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '  ${state.data.temperature}\u2103  ',
                    style: const TextStyle(
                        fontSize: 70, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' Humidity is ${state.data.humidity}, ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    " Check weather for any City",
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight:
                          FontWeight.bold, // Adjust the font weight as needed
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, WeatherScreen.page);
                      },
                      child: const Text(
                        "Click",
                        style: TextStyle(
                          color: Colors.white,
                          // Change the text color as needed
                          fontSize: 12,
                          // Adjust the font size as needed
                          fontWeight: FontWeight
                              .bold, // Adjust the font weight as needed
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            );
          }

          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.black, strokeWidth: 10.0),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                "Loading",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              ))
            ],
          );
        },
      ),
    );
  }
}
