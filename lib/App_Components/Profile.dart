import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:childrights/Login_Signup/Login.dart';
import '../Provider_Models/Users.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
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
                      'images/splash.png',
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
                        // Add this section to log the user out and require login again
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
                    backgroundImage: AssetImage('images/boy.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.email ?? 'User Email', // Display user email
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
          ],
        ),
      ),
    );
  }
}
