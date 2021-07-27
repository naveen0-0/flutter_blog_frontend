import 'package:flutter/material.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({ Key? key }) : super(key: key);
  @override
  _SignUpWithEmailState createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {

  bool showPassword = false;
  final _formKey = GlobalKey<FormState>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up",style: TextStyle(color: Colors.blueGrey),),
        elevation: 0.0,
        backgroundColor: Colors.green.shade100,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Container(
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
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Signup with email",style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey
                ),),
              ),
              SizedBox(height: 20,),
        
              //!Username
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: "Enter your username",
                    labelText:"Username",
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Username can't be empty";
                      //* Check is username is unique or not
                    }
                    return null;
                  },
                ),
              ),
              //!Password
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    prefixIcon:Icon(Icons.security),
                    suffixIcon: IconButton(onPressed: (){ setState(() {
                      showPassword = !showPassword;
                    });}, icon: showPassword? Icon(Icons.visibility) : Icon(Icons.visibility_off)),
                    border: OutlineInputBorder(),
                    hintText: "Enter your password",
                    labelText:"Password",
                    helperText: "Password should be greater than 8 chars"
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Password can't be empty";
                    }
                    if(value.length<=8){
                      return "Password length should be greater than 8";
                    }
                  },
                ),
              ),
              //!Email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: "Enter your email",
                    labelText:"Email"
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Email can't be empty";
                    }
                    if(!value.contains('@')){
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                
              ),
        
              //* Submit Button
              MaterialButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  print("Validated");
                }
              },child: Text("Signup",style: TextStyle(color: Colors.white70),),color: Colors.blueGrey,elevation: 0.0,)
            ],
          ),
        ),
      ),
    );
  }
}