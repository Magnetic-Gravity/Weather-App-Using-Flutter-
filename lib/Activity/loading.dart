import 'package:flutter/material.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String city =  "Mumbai";
  String? temp;
  String? hum;
  String? press;
  String? desc;
  String? main;
  String? icon;
  String? air_speed;
  String? deg;

  void startApp(String city) async{
    worker instance = worker(location: city);
    await instance.getData();
    temp =  instance.temperature;
    hum =   instance.humidity;
    press = instance.pressure;
    desc =  instance.description;
    main =  instance.main;
    icon =  instance.icon;
    air_speed = instance.airSpeed;
    deg = instance.degree;

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        "temp_value":temp,
        "hum_value":hum,
        "press_value":press,
        "desc_value":desc,
        "main_value":main,
        "icon_value":icon,
        "air_speed_value":air_speed,
        "degree_value":deg,
        "city_value":city

      });
    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map search = (ModalRoute.of(context)?.settings.arguments??{}) as Map;

    if(search?.isNotEmpty ?? false){
      city = search['searchText'];
    }
    startApp(city);

    return Scaffold(
      appBar: AppBar(
        title: Text("LOADING PAGE",),
        backgroundColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Image.asset("images/weather3.jpeg",height: 200,width: 200,),
              SizedBox(height: 80,),
              Text("Weather APP",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
              SizedBox(height: 10,),
              Text("Made By Moin",style:TextStyle(fontSize: 15,fontWeight: FontWeight.w500,),),
              SizedBox(height: 30,),
              SpinKitWave(
                color: Colors.teal,
                size: 70.0,
              ),
        
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blue[100],
    );
  }
}
