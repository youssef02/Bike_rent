import 'package:app/llmap.dart';
import 'package:app/qrscanner.dart';
import 'package:app/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';





class MainMenu extends StatefulWidget {
   MainMenu({Key? key, required User this.user}) : super(key: key);

  User user;
  @override
  State<MainMenu> createState() => _MainMenu(user.photoURL!);
}

class _MainMenu extends State<MainMenu> {
  late String photoURL = "";
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[];

  _MainMenu(String photoURL)
  {
    this.photoURL = photoURL;
  }


  @override
  void initState() {

    super.initState();
    _widgetOptions = <Widget>[
    QRscanner(),
    Llmap(),
    Settings(usrimg: photoURL),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QRcode',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
