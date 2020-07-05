import 'package:geolocator/geolocator.dart';
//import 'package:weather/weather_library.dart';

class Location {
  double latitude;
  double longitude;
  Position position;
  List<Placemark> placemark;
  double temperature;
  String city;

  // Weather weather;

  // WeatherStation weatherStation =
  //     WeatherStation('f52e3b76fa745826ebb5c9b8acde44d4');

  Future<void> getLocation() async {
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      // city = placemark[0].administrativeArea;
      placemark =
          await Geolocator().placemarkFromCoordinates(latitude, longitude);
      //  print(longitude);
    } catch (e) {
      print('THis is the exceptio of getLocation: $e');


    }

   
  }
}
