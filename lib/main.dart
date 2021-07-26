import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Text("Hello World")
          ),
        ),
      ),
    );
  }
}