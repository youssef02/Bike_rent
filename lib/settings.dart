
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';
import 'authmenu.dart';

class Settings extends StatefulWidget{
  const Settings({Key? key, required String this.usrimg}) : super(key: key);
  final String  usrimg;



  @override
  State<StatefulWidget> createState() => _Settings(this.usrimg);

}

class _Settings extends State<Settings> {

  String urlprofile = "";
  _Settings(String url)
  {
  this.urlprofile = url;
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AuthMenu(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [

          SizedBox(
            height: 32,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width ,
            child:
            Stack(
              clipBehavior: Clip.none,

              children: [
                //Avatar Circle at Center
                Center(
                  child:
                  CircleAvatar(
                    backgroundImage: NetworkImage(urlprofile),
                    backgroundColor: Colors.transparent,
                    radius: MediaQuery
                        .of(context)
                        .size
                        .width / 4,
                  ),
                ),

                Positioned(
                    bottom: 0,
                    right: MediaQuery.of(context).size.width/4,
                    child: RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Color(0xFFF5F6F9),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )),
                Positioned(
                    bottom: 0,
                    right: 32,
                    child: RawMaterialButton(
                      onPressed: () async {
                        await Authentication.signOut(context: context);
    Navigator.of(context)
        .pushReplacement(_routeToSignInScreen());

                      },
                      elevation: 2.0,
                      fillColor: Color(0xFFF5F6F9),
                      child: Icon(Icons.logout, color: Colors.red,),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          ListTile(

            leading: FlutterLogo(size: 56.0),
            title: Text("Profile"),
            subtitle: Text("username, ..."),

          ),
          SizedBox(
            height: 32,
          ),
          ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text("Privacy settings"),
            subtitle: Text("PG, Age Filter..."),

          ),
          SizedBox(
            height: 32,
          ),
          ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text("Bike renting Data"),
            subtitle: Text("renting logs, location logs,..."),

          )
        ],

      ),
    );
  }


}