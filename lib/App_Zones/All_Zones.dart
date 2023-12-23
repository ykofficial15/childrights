import 'package:childrights/App_Components/Music.dart';
import 'package:childrights/App_Components/Quote.dart';
import 'package:childrights/App_Zones/Chatbot/chat_screen.dart';
import 'package:childrights/App_Zones/Comics.dart';
import 'package:childrights/App_Zones/Ebooks.dart';
import 'package:childrights/App_Zones/Games/TicTacToe.dart';
import 'package:childrights/App_Zones/Q&A.dart';
import 'package:flutter/material.dart';
import 'Games/Image_Quiz.dart';


class AllZones extends StatefulWidget {
  const AllZones({super.key});

  @override
  State<AllZones> createState() => _AllZonesState();
}

class _AllZonesState extends State<AllZones> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        //box 1 started from here created by yogesh
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>TicTacToeScreen(),
              ),
            );
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(3),
              width: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/z1.png',
                      ),
                      fit: BoxFit.cover)),
              child: Text(
                'Games',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
        //box 2 started from here created by yogesh
        InkWell(
          onTap: () {
                                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            );
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(3),
              width: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/z2.png',
                      ),
                      fit: BoxFit.cover)),
              child: Text(
                'eBooks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
        //box 3 started from here created by yogesh
        InkWell(
          onTap: () {},
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(3),
              width: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/z3.png',
                      ),
                      fit: BoxFit.cover)),
              child: Text(
                'Videos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
        //box 4 started from here created by yogesh
        InkWell(
          onTap: () {

               Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>MCQScreen(),
              ),
            );
          },
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(3),
              width: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/z4.png',
                      ),
                      fit: BoxFit.cover)),
              child: Text(
                'Q&A',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}
