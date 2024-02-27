import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/weather/model.dart';

@injectable
class DioService {

  final Dio _dio = Dio();

  Future<WeatherData?> getWeather(String lat, String lon) async {
    try {
      Response response = await _dio.get("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=41fae732f3d229cc7b27166f8e0c3bff&units=metric",);
      if (response.statusCode == 200) {
        dynamic jsonData = response.data;
        double temperature = jsonData['main']['temp'];
        String cityName = jsonData['name'];
        int humidity = jsonData['main']['humidity'];
        return WeatherData(temperature: temperature, cityName: cityName, humidity: humidity);
      } else {
        print("Failed to fetch weather data. Status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      // Handle errors
      print("Error: $error");
      return null;
    }
  }


  Future<double?> getTempWithLocation(String location) async {
    try {
      // Make HTTP GET request to the API using Dio
      Response response = await _dio.get(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=41fae732f3d229cc7b27166f8e0c3bff&units=metric",
      );

      // Check if request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic jsonData = response.data;
        double temperature = jsonData['main']['temp'];
        print(temperature);
        return temperature;
      } else {
        // Handle unsuccessful request
        print(
            "Failed to fetch weather data. Status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }

}