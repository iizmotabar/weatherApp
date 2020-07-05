import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String cityName;

  WeatherModel weatherModel = WeatherModel();
  Location location = Location();
  var weatherData;

  @override
  void initState() {
    // getData();
    getLocationAndWeatherData();
   // print(getCityName());

    super.initState();
  }

  // dynamic getCityName() {
  //   cityName = value;
  //   return cityName;
  // }

  void getLocationAndWeatherData() async {
    weatherData = await weatherModel.getWeatherData();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
            
          );
        },
      ),
    );

    // print(location.placemark[0].postalCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: SpinKitDoubleBounce(
            color: Colors.grey,
          )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
                'Processing the request. Please wait.\n \n Make sure Location and Internet Connection is turned on.',
                textAlign: TextAlign.center,
                style: kMessageTextStyle.copyWith(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
