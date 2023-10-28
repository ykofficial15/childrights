import 'dart:async';
import 'package:flutter/material.dart';
import '../App_Zones/All_Zones.dart';
import 'My_Slideshow.dart';
import 'Quote.dart';
import 'Search_Box.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView(  
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Text(
                            'Hey Champ!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Unleashing Wonder in Every Child',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 230, 0),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    ),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                      height: 130.0,
                      child: AllZones(),
                    ),
                   Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    alignment: Alignment.centerLeft,
child:Text('Quote of the day?',style:TextStyle(color:Colors.purple,fontSize: 25,fontWeight: FontWeight.bold))
                   ),
                  Container(
                    decoration: BoxDecoration(
                     image: DecorationImage(image: AssetImage('images/quoteboard.jpg'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.all(5),
                    child:Quote(),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
