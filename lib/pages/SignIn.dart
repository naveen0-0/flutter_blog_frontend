import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Networkhandler.dart';
import 'HomePage.dart';
import 'SignUpWithEmail.dart';



class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showPassword = true;
  final _globalkey = GlobalKey<FormState>();

  NetWorkHandler networkHandler = NetWorkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errorText="";
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In",style: TextStyle(color: Colors.blueGrey),),
        elevation: 0.0,
        backgroundColor: Colors.green.shade100,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade200],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Form(
          key: _globalkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
            child: Column(
              children: [
                SizedBox(height: 20,),
                //!Username
                Padding( 
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      hintText: "Enter your username",
                      labelText:"Username",
                      errorText: validate?null:errorText
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: showPassword,
                    decoration: InputDecoration(
                      prefixIcon:Icon(Icons.security),
                      suffixIcon: IconButton(onPressed: (){ setState(() {
                        showPassword = !showPassword;
                      });}, icon: !showPassword? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                      border: OutlineInputBorder(),
                      hintText: "Enter your password",
                      labelText:"Password",
                      helperText: "Password should be greater than 8 chars",
                      errorText: validate?null:errorText
                    ),
                  ),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpWithEmail()));
                  },
                  child: Text(
                    "New User?",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                MaterialButton(
                  color: Colors.blueGrey,
                  elevation: 0.0,
                  child: circular? 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ) : Text("Sign In",style: TextStyle(color: Colors.white70),
                    ),
                  onPressed: () async {
                    setState(() {
                      circular = true;
                    });

                    //!Login Logic start here
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "password": _passwordController.text,
                    };
                    var response = await networkHandler.post("/user/login", data);

                    if (response.statusCode == 200 || response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output["token"]);
                      await storage.write(key: "token", value: output["token"]);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    } else {
                      String output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = output;
                        circular = false;
                      });
                    }
                    // login logic End here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}