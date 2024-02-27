import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/application/auth/auth_bloc.dart';
import 'package:weather_app/application/weather/weather_bloc.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/presentation/auth/sign_in_screen.dart';
import 'package:weather_app/presentation/auth/sign_up_screen.dart';
import 'package:weather_app/presentation/splash/splash_screen.dart';
import 'package:weather_app/presentation/weather/location_screen.dart';
import 'package:weather_app/presentation/weather/weather_screen.dart';
import 'package:weather_app/presentation/weather/weather_ui_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  configureDependencies(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.page,
      routes: {
        SignupPage.page: (context) => BlocProvider(
              create: (context) => getIt<AuthBloc>(),
              child: const SignupPage(),
            ),
        SigninPage.page: (context) => BlocProvider(
              create: (context) => getIt<AuthBloc>(),
              child: const SigninPage(),
            ),
        Splash.page: (context) => const Splash(),
        WeatherScreen.page: (context) => BlocProvider(
          create: (context) => getIt<WeatherBloc>(),
          child: const WeatherScreen(),
        ) ,
        LocationPage.page: (context) => BlocProvider(
          create: (context) => getIt<WeatherBloc>()..add(SearchCityLocationEvent()),
          child: const LocationPage(),
        ) ,
      },
    );
  }
}
