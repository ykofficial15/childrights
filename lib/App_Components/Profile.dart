import 'package:childrights/App_Zones/Chatbot/chat_screen.dart';
import 'package:childrights/App_Zones/Ebooks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:childrights/Login_Signup/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '../Provider_Models/Users.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  String userName = "User Name"; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    if (user != null) {
      // Fetch the user's name from Firestore
      FirebaseFirestore.instance
          .collection("Children_Signup")
          .doc(user!.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          setState(() {
            userName = doc.data()?["Name"] ?? "User Name";
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/splash.png',
                      height: 150,
                      width: 150,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 40),
                    child: IconButton(
                      icon: Icon(Icons.logout_rounded, color: Colors.white),
                      tooltip: 'LogOut',
                      onPressed: () {
                        final authProvider =Provider.of<Authenticate>(context, listen: false);
                        authProvider.logout();

                        // Navigate to the login page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: (MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 255, 123, 0),
                    radius: 60,
                    backgroundImage: AssetImage('assets/boy.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName, // Display the user's name
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Center(
              child:Container(
                height: 350,
                child: ChatScreen())
            )
          ],
        ),
      ),
    );
  }
}
