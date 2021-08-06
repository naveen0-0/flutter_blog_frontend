import 'package:blog/Networkhandler.dart';
import 'package:flutter/material.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({ Key? key }) : super(key: key);
  @override
  _SignUpWithEmailState createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();
  NetWorkHandler netWorkHandler = NetWorkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String errorText = "";
  bool validate = false;
  bool circular = false;

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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
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
              //!Password
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: "Enter your email",
                    labelText:"Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Email can't be empty";
                    }
                    if(!value.contains('@')){
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
              ),
        
              //* Submit Button
              MaterialButton(
                onPressed: () async {
                  setState(() {
                    circular=true;
                  });
                  await checkUser();
                  if(_formKey.currentState!.validate() && validate){
                    Map<String,String> data = {
                      "username":_usernameController.text,
                      "password":_passwordController.text,
                      "email":_emailController.text,
                    };
                    await netWorkHandler.post('/user/register', data);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Registered Successfully"),duration: Duration(seconds: 2),));
                    setState(() {
                      circular=false;
                    });
                  }else{
                    setState(() {
                      circular=false;
                    });
                  }
                },
                child: circular? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ) : Text("Signup",style: TextStyle(color: Colors.white70),),
                color: Colors.blueGrey,
                elevation: 0.0
              )
            ],
          ),
        ),
      ),
    );
  }

  checkUser() async {
    if(_usernameController.text.length == 0){
      setState(() {
        circular=false;
        validate=false;
        errorText="Username can't be empty";
      });
    }else{
      var response = await netWorkHandler.get('/user/checkusername/${_usernameController.text}');
      if(response['status']){
        setState(() {
          circular=false;
          validate=false;
          errorText="Username already taken";
        });
      }else{
        setState(() {
          validate=true;
        });
      }
    }
  }
}