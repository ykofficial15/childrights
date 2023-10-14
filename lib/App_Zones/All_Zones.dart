import 'package:flutter/material.dart';

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
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(3),
                                width: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'images/z1.png',
                                        ),
                                        fit: BoxFit.cover)),
                                child: Text(
                                  'Games',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          //box 2 started from here created by yogesh
                          InkWell(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(3),
                                width: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'images/z2.png',
                                        ),
                                        fit: BoxFit.cover)),
                                child: Text(
                                  'eBooks',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'images/z3.png',
                                        ),
                                        fit: BoxFit.cover)),
                                child: Text(
                                  'Videos',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          //box 4 started from here created by yogesh
                          InkWell(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(3),
                                width: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'images/z4.png',
                                        ),
                                        fit: BoxFit.cover)),
                                child: Text(
                                  'Q&A',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ],
                      );
  }
}