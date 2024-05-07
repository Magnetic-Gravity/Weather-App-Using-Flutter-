import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton.icon(onPressed: (){
              Navigator.pushNamed(context, "/loading");
            }, icon: Icon(Icons.next_plan), label: Text('Loading again'))
          ],
        ),
      ),
    );
  }
}
