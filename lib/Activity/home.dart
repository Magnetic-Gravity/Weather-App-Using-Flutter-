import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('this is init state');

  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print('set state called');
  }


  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai","Delhi","Chennai","Goa","Bengluru","Shimla","Kolkata","Shillong","Indore","Jaipur"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    Map info = ModalRoute.of(context)?.settings.arguments as Map;

    String temp = (info['temp_value']).toString();
    String air = ((info['air_speed_value']).toString());

    if(temp=="NA"){
      print("NA");
    }else{
      temp = ((info['temp_value']).toString()).substring(0,5);
      air = ((info['air_speed_value']).toString()).substring(0,5);
    }

    String hum = info['hum_value'];
    String press = info['press_value'];
    String desc = info['desc_value'];
    String main = info['main_value'];
    String icon = info['icon_value'];
    String getcity = info['city_value'];
    String deg = info['degree_value'];



    return Scaffold(
      appBar: AppBar(
          title: Text('Weather Forcast - Live'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.black38, Colors.black12]
                )
            ),
          )
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.3, // 0 - 30%
                  0.8 // 80% - 100%
                ],
                colors: [
                  Colors.blueGrey,
                  Colors.black12
                ]
              )
            ),
            child: Column(
              children: [

                Container( //Search Container
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.fromLTRB(15, 20, 14, 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if((searchController.text).replaceAll(" ","") == ""){
                            print("Blank Search");
                          }else{
                            Navigator.pushReplacementNamed(context, "/loading",arguments: {
                              "searchText" : searchController.text,
                            });
                          }
                        },
                        child: Container(child: Icon(Icons.search,color: Colors.white,),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Enter City Name here",
                            hintStyle: TextStyle(fontSize: 20,color: Colors.white),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),


                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                              SizedBox(width: 15,),
                              Column(
                                children: [
                                  Text('Description: $desc',style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  Text('Main : $main',style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text('In $getcity',style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),)
                                ],
                              )
                            ],
                          ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6,),


                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 230,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer,size: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$temp',style: TextStyle(fontSize: 90,color: Colors.white),),
                                Text('°C',style: TextStyle(fontSize: 40,color: Colors.white),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(15, 10,8, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.day_cloudy_windy,size: 30,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('$air',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('km/hr',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(8, 10, 14, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity,size: 30,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('$hum',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('Percent',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(15, 10,8, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.barometer,size: 30,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('$press',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('hPa',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.fromLTRB(8, 10, 14, 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.degrees,size: 40,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('$deg',style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
                            Text('Degrees',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Column(
                    children: [
                      Text('MADE BY MOIN KHAN',style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),),

                      Text('DATA PROVIDED BY OPEN-WEATHER-MAP',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,

                      ),),
                    ],
                  ),
                ),

        
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*




   void getData() async{
   Response response = await  get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=0ef016a5e9ff32352537f89fcab8eaa0"));
   Map data = jsonDecode(response.body);

   Map temp_data = data['main'];
   double temp = temp_data['temp'];
   print(temp);

   List weather_data = data['weather'];
   Map weather_main_data = weather_data[0]; // data which is at zero'th index
   print(weather_data);
   print(weather_main_data);

  }


   String? name;
   Future<void> getData() async {
   await Future.delayed(Duration(seconds: 4),(){
      name = "moin";
   });
  }
  //async function
  void showData() async{
    await getData();
    print('$name');
  }
  @override
  void initState() {
    super.initState();
    showData();
    print('this is init state');
  }




  String? name;
  //Async == Functions start at starting but Return after some time
  void getData() async{
     await Future.delayed(Duration(seconds: 4),(){
       name = "moin";
     });
     print('$name');
  }
  @override
  void initState() {
    super.initState();
    getData();
    print('this is init state');
  }


   //Async == Functions start at starting but Return after some time
  //Future.delayed == Function start and return after some time
  void getData(){
    Future.delayed(Duration(seconds: 4),(){
      name = "moin";
    });
  }



  void timer(){
    //process 5 seconds
    Future.delayed(Duration(seconds: 6),(){
      print("alarm is ringing");
    });
    print("You can do other Other Stuff too");
  }
  @override
  void initState() {
    super.initState();
    timer();
    print('this is init state');
  }


 */