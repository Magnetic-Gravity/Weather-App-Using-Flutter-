import 'dart:convert';  //it is used for json decode
import 'package:http/http.dart';

// class - method - instance
class worker{
  String? location;
  String? temperature;
  String? humidity;
  String? pressure;
  String? description;
  String? main;
  String? icon;
  String? airSpeed;
  String? degree;

  //constructor for location
  worker({this.location}){ // inside curly brackets it is a named parameter like this ->>>> location:"delhi"
    location = this.location;
  }

  //method of worker class
  Future<void> getData() async{
    try{
      Response response = await  get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=0ef016a5e9ff32352537f89fcab8eaa0"));
      Map data = jsonDecode(response.body);
      // print(data);

      // Temp && Humidity && Pressure
      Map main_data = data['main'];
      double get_temperature = main_data['temp'] - 273.15;
      String get_humidity = main_data["humidity"].toString();
      String get_pressure = main_data['pressure'].toString();
      // Description && Icon && Main
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0]; // data which is at zero'th index
      String get_main = weather_main_data['main'];
      String get_description = weather_main_data['description'];
      String get_icon = weather_main_data['icon'].toString();
      //Air Speed  && degree
      Map wind_data = data['wind'];
      double get_air_speed = wind_data['speed'] / 0.27777777777778;
      String get_degree = wind_data['deg'].toString();

      //assigning values
      temperature = get_temperature.toString(); // Celcius
      humidity = get_humidity; // Percentage (%)
      pressure = get_pressure; // atmospheric pressure on sea level (hPa)
      description = get_description;
      main = get_main;
      icon = get_icon;
      airSpeed = get_air_speed.toString();// here it is in KM/h   //Unit Default: meter/sec, Imperial: miles/hour
      degree = get_degree; //degrees (meteorological)

    }catch(e){
      temperature = "NA";
      humidity = "NA";
      pressure = "NA";
      description = "can't find data";
      main = "Not Available";
      icon = "09d";
      airSpeed = "NA";
      degree = "NA";
    }

  }

}
