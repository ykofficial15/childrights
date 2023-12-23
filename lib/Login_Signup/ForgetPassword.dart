import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailController = TextEditingController();

  void sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        print('Password reset email sent');
        Fluttertoast.showToast(
            msg: "Check Your Mail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      } catch (e) {
        print('Failed to send password reset email: $e');
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(
              msg: 'Email does not exist',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor:Colors.red,
              textColor: Colors.white,
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Failed to send password reset email',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor:Colors.red,
              textColor: Colors.white,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Failed to send password reset email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor:Colors.red,
            textColor: Colors.white,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
           height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:BoxDecoration(
         image: DecorationImage(image: AssetImage('assets/bg.png',),fit: BoxFit.cover)
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
        width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/splash.png',height: 150,width: 150,alignment: Alignment.centerLeft),
       ),
              SizedBox(height: 150),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Reset Your Password',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Here',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:Colors.black), // Set your desired Outline color here
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Set your desired unfocused border color here
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.mail, color: Colors.purple),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.purple)),
                  onPressed: () =>
                      sendPasswordResetEmail(_emailController.text),
                  child: Text('Send Reset Email',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
