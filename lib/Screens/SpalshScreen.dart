import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/HomePage.dart';

class AppStart extends StatefulWidget{
@override
  AppStartState createState() => AppStartState();
}

class AppStartState extends State<AppStart>{
  final splashdelay=5;
  
  @override
  void initState(){
    super.initState();
    
    _Load();
  }
  
  _Load() async{
    final _duration= Duration(seconds: splashdelay);
    return Timer(_duration, navigationPage);
  }
  
  void navigationPage(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: InkWell(
      child: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          Image(
           image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'),
           ), 
          CircularProgressIndicator(),
         ]
         
       ),
      ),
     ),   
    );
  }
}