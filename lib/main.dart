import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blog/pages/welcome_page.dart';
import 'package:blog/pages/HomePage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }
  
  void checkLogin() async {
    String? token = await storage.read(key: "token");
    if(token!= null){
      page = HomePage();
    }else{
      page = WelcomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      debugShowCheckedModeBanner: false,
      home: page
    );
  }
}