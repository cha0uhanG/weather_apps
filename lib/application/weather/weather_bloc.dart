import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/weather/dio_service.dart';
import 'package:weather_app/domain/weather/model.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/preference.dart';

@injectable
class WeatherBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

@injectable
class WeatherBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

@injectable
class SearchCityEvent extends WeatherBlocEvent {
  final String cityName;

  SearchCityEvent(this.cityName);
}

@injectable
class SearchCityLocationEvent extends WeatherBlocEvent {
  final String lat;
  final String lng;

  SearchCityLocationEvent(this.lat, this.lng);
}

@injectable
class WeatherState extends WeatherBlocEvent {}

@injectable
class InitialWeatherState extends WeatherBlocState {}

@injectable
class LoadingWeatherState extends WeatherBlocState {}

class WeatherFailureState extends WeatherBlocState {
  final String message;

  WeatherFailureState(this.message);
}

class WeatherResponseState extends WeatherBlocState {
  final WeatherData data;

  WeatherResponseState(this.data);
}

@injectable
class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  String latitude = 'Fetching...';
  String longitude = 'Fetching...';

  WeatherBloc() : super(InitialWeatherState()) {
    // event handler was added
    on<WeatherBlocEvent>(mapEventToState);
  }


  Stream<WeatherBlocState> mapEventToState(WeatherBlocEvent event,
      Emitter<WeatherBlocState> emit) async* {
    if (event is SearchCityEvent) {
      yield LoadingWeatherState();
      try {
        var dioService = getIt<DioService>();
        var response = await dioService.getTempWithLocation(event.cityName);
        print(response);
      } catch (e) {
        yield WeatherFailureState(e.toString());
      }
    } else if (event is InitialWeatherState) {
      // yield LoadingWeatherState();
      var dioService = getIt<DioService>();
      var responseOne = await dioService.getTempWithLocation("Almora");
      print(responseOne);
      await Geolocator.checkPermission();
      await Geolocator.requestPermission(); // asking permssion from user
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high); // exxtracting location
      var latitude = position.latitude.toString();
      var longitude = position.longitude.toString();
      WeatherData? response =
      await dioService.getWeather(latitude, longitude);
      if (response != null) {
        MyPref().temp.val = response.temperature;
        MyPref().stateName.val = response.cityName;
        MyPref().humidity.val = response.humidity;
      } else {
        response = WeatherData(temperature: MyPref().temp.val,
            cityName: MyPref().stateName.val,
            humidity: MyPref().humidity.val);
      }
      yield WeatherResponseState(response);
      /* try {

        print(response);
      } catch (e) {
        yield WeatherFailureState(e.toString());
      }*/
    }
  }
}
