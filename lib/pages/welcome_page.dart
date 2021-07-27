import 'package:blog/pages/SignUpWithEmail.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key? key }) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}


class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.green.shade200
              ],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0,1.0],
              tileMode: TileMode.repeated
            )
          ),
          child:Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("BlogReal",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.purple[900]),),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/8,),
              Text("Great Stories for Great People",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
              SizedBox(height:20),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpWithEmail() 
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sign up",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?",style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17
                  ),
                  ),
                  SizedBox(width: 10,),
                  Text("SignIn",style: TextStyle(
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}