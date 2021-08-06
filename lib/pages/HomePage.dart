import 'package:flutter/material.dart';
import '../screens/HomeScreen.dart';
import '../screens/ProfileScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [HomeScreen(),ProfileScreen()];
  List<String> titles = ["HomePage","Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[currentState]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){},
          )
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("@username"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.all_inbox),
              title: Text("All Posts"),
              onTap: (){},
            ),
          ],
        ),
      ),
      body: widgets[currentState],
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  color: currentState==0?Colors.white:Colors.white54,
                  icon: Icon(Icons.home),
                  onPressed: (){
                    setState(() {
                      currentState=0;
                    });
                  },
                ),
                IconButton(
                  color: currentState==1?Colors.white:Colors.white54,
                  icon: Icon(Icons.person),
                  onPressed: (){
                    setState(() {
                      currentState=1;
                    });
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