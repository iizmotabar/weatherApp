import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
//  final  Function cityNameFxn;
  final dynamic locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  dynamic weatherData;
  double temperature;
  // int condition;
  String cityName;
  String weatherMessage;
  String weatherIcon;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    weatherData = (widget.locationWeather);

    super.initState();
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        //  condition = 0;
        weatherIcon = 'Error';
        cityName = '';
        weatherMessage = 'Something went wrong.';
        return;
      } else {
        print(weatherData);
        temperature = weatherData['main']['temp'] - 273.15;
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        cityName = weatherData['name'];
        weatherMessage = weatherModel.getMessage(temperature.toInt());
      }
    });
  }

  // temperature= = weatherData['main']['temp'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.getWeatherData();
                        updateUI(weatherData);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                          Text('Current Location')
                        ],
                      )),
                  FlatButton(
                      onPressed: () async {
                        var cityName = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        if (cityName != null) {
                          var weatherData =
                              await weatherModel.getCityWideData(cityName);
                          updateUI(weatherData);
                         
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.location_city,
                            size: 50.0,
                          ),
                          Text('Search by City')
                        ],
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      ' ${temperature.toStringAsFixed(0)}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  'In $cityName, $weatherMessage ',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// int condition = decodedData['weather'][0]['id'];
// String cityName = decodedData['name'];
