import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signup(),
    );
  }
}

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String sname, semail, spassword;

  void saveToFirestore() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      try {
        await Firebase.initializeApp();

        // Save to authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: semail,
          password: spassword,
        );

        // Save to Firestore database
        final uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('Children_Signup').doc(uid).set({
          'Name': sname,
          'Email': semail,
          'Password': spassword,
        }).then((result){
        // Sign up successful
        Fluttertoast.showToast(
          msg: "Registration successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          fontSize: 16.0,);
      });

        form.reset();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showErrorMessage("Too weak password");
        } else if (e.code == 'email-already-in-use') {
          showErrorMessage("Email already exists");
        }
      } catch (e) {
        showErrorMessage("Error in saving data");
      }
    }
  }

  void showErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      timeInSecForIosWeb: 1,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'images/splash.png',
                  height: 150,
                  width: 150,
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(height: 100),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a new account',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Signup to continue',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 44.0),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Enter your name",
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: "Child Name",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.purple),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => sname = value!,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(Icons.mail, color: Colors.purple),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) => semail = value!,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: "Set Password",
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(Icons.pin, color: Colors.purple),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) => spassword = value!,
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Note: If you\'re below 18 login with\n your parents email id',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(8),
                              fillColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              onPressed: () {
                                saveToFirestore();
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
