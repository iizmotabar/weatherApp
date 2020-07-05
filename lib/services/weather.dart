import 'package:clima/services/location.dart';
import 'package:clima/services/network.dart';

const String apiKey = 'f52e3b76fa745826ebb5c9b8acde44d4';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
// 'api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}'

const cityLevelApiUrl = 'api.openweathermap.org/data/2.5/weather';
Location location = Location();

class WeatherModel {
  // var weatherData;
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Future<dynamic> getCityWideData(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&unit=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    await location.getLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s too hot. Have an 🍦';
    } else if (temp > 20) {
      return 'Its Time for shorts and 👕';
    } else if (temp < 10) {
      return 'Too cold out there. You\'ll need 🧣 and 🧤';
    } else {
      return 'Just in case, Don\'t forget to wear 🧥 ';
    }
  }
}
