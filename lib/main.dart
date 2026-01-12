import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'Home page.dart';
import 'api.dart';
void main() {
  runApp(
    DevicePreview(
        enabled: true,
        builder: (context)=>MyApp())
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Api_Calling_Practice Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home:  TourListScreen(),
      home: ApiCall(),
    );
  }
}
