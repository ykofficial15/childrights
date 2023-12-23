import 'dart:async';
import 'package:childrights/App_Components/Music.dart';
import 'package:childrights/Login_Signup/Login.dart';
import 'package:childrights/Provider_Models/Users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Animations/Glow.dart';
import '../App_Zones/All_Zones.dart';
import 'My_Slideshow.dart';
import 'Quote.dart';
import 'Search_Box.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 30, 5, 25),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hey Champ!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout_rounded, color: Colors.white),
                        tooltip: 'LogOut',
                        onPressed: () {
                          final authProvider =
                              Provider.of<Authenticate>(context, listen: false);
                          authProvider.logout();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Unleashing Wonder in Every Child',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 230, 0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: "Choose",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.purple,
                ),
                children: [
                  TextSpan(
                    text: " \nwhat to learn today?",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: SearchBox(),
          ),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.all(3),
            height: 200,
            child: MySlideshow(),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text('Recommend',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          Container(
            height: 130.0,
            child: AllZones(),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text('Quote of the day?',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/quoteboard.jpg'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.all(5),
            child: Quote(),
          ),
          Divider(
            color: Colors.deepOrange,
            thickness: 2,
            endIndent: 100,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/cover.jpg'), fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  GlowingTextAnimation(),
                ],
              )),
          Divider(
            color: Colors.deepOrange,
            thickness: 2,
            indent: 100,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text('Feel Free Music',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          Center(
            child: Container(
              height: 250,
              child: MusicPlayer(),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
