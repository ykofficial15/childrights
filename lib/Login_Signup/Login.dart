import 'package:childrights/Login_Signup/ForgetPassword.dart';
import 'package:childrights/Login_Signup/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../App_Components/Bottom_Navigation.dart';
import '../Provider_Models/Users.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  int? _selectedIndex = 0;
  late String semail, spassword;
  late String femail, fpassword;

//------------------------------------------------------------------------------------------------- Student Login
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _checkUserExist() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: semail,
          password: spassword,
        );
        Fluttertoast.showToast(
          msg: 'Login successful!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: "User not found for that email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg: "Entered wrong password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Error in saving data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  //----------------------------------------------------------------------------------------------------- Faculty Login
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  void _checkTeacherExist() async {
    final form2 = _formKey2.currentState;
    if (form2!.validate()) {
      form2.save();
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: femail,
          password: fpassword,
        );
        Fluttertoast.showToast(
          msg: 'Login successful!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: "User not found for that email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg: "Entered wrong password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Error in saving data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

//------------------------------------------------------------------------------------------------------ Form 1 and Form 2 Shifting
  void _onIndexChanged(int? index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final authProvider = Provider.of<AuthProvider>(context, listen: false); 
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/bg.png',
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
//--------------------------------------------------------------------------------------------------------------------------Logo Heading
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset('images/splash.png',
                  height: 150, width: 150, alignment: Alignment.centerLeft),
            ),
            //--------------------------------------------------------------------------------------------------------------------------Radio Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                ),
                Radio(
                  overlayColor: MaterialStatePropertyAll(
                      Color.fromARGB(99, 155, 39, 176)),
                  focusColor: Colors.purple,
                  fillColor: MaterialStatePropertyAll(Colors.purple),
                  value: 0,
                  groupValue: _selectedIndex,
                  onChanged: _onIndexChanged,
                ),
                Text(
                  'Child',
                  style: TextStyle(color: Colors.purple),
                ),
                SizedBox(width: 10),
                Radio(
                  overlayColor: MaterialStatePropertyAll(
                      Color.fromARGB(99, 155, 39, 176)),
                  focusColor: Colors.purple,
                  fillColor: MaterialStatePropertyAll(Colors.purple),
                  value: 1,
                  groupValue: _selectedIndex,
                  onChanged: _onIndexChanged,
                ),
                Text(
                  'Admin',
                  style: TextStyle(color: Colors.purple),
                ),
              ],
            ),
//------------------------------------------------------------------------------------------------ Radio Button Indexing
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
//------------------------------------------------------------------------------------------------------------------ Form 1
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//------------------------------------------------------------------------------------------------------------------ Login Headings
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Welcome to CRQ',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 44.0,
                        ),
//---------------------------------------------------------------------------------------------------------- Form 1 Fields
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              //---------------------------------------------------------- Email Field
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: "Email",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired Underline color here
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired unfocused border color here
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon:
                                      Icon(Icons.mail, color: Colors.purple),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                onSaved: (value) => semail = value!,
                              ),
                              const SizedBox(
                                height: 26.0,
                              ),
                              //------------------------------------------------------------------------ Password Field
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired Underline color here
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired unfocused border color here
                                  ),
                                  prefixIcon: Icon(Icons.lock_person_rounded,
                                      color: Colors.purple),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onSaved: (value) => spassword = value!,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              //---------------------------------------------------------------------------- Register
                              FittedBox(
                                child: Row(children: [
                                  const Text(
                                    'Dont have an account?  ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup(),));
                                    },
                                    child: Text(
                                      'Register Now',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Text(
                                    '  or  ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgetPassword(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 88.0,
                        ),
//-------------------------------------------------------------------------------------------------------- Form 1 Login Button
                    
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          child: RawMaterialButton(
                            fillColor: Colors.purple,
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            onPressed: () {
                              _checkUserExist();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //----------------------------------------------------------------------------------------------------- Form 2
                  Form(
                    key: _formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//------------------------------------------------------------------------------------------------------------------ Login Headings
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Login as CRQ Admin',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 44.0,
                        ),
//---------------------------------------------------------------------------------------------------------- Form 2 Fields
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              //---------------------------------------------------------- Email Field
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: "Faculty Email",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired Underline color here
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired unfocused border color here
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon:
                                      Icon(Icons.mail, color: Colors.purple),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                onSaved: (value) => femail = value!,
                              ),
                              const SizedBox(
                                height: 26.0,
                              ),
                              //------------------------------------------------------------------------ Password Field
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                obscureText: true,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: "Password",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired Underline color here
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .black), // Set your desired unfocused border color here
                                  ),
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(Icons.lock_person_rounded,
                                      color: Colors.purple),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onSaved: (value) => fpassword = value!,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              // Container(
                              //   child: Row(children: [
                              //     const Text(
                              //       'Dont have an account?  ',
                              //       style: TextStyle(color:Colors.black),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           SmoothPageRUndere(
                              //             child: Fsignup(),
                              //           ),
                              //         );
                              //       },
                              //       child: Text(
                              //         'Register Now',
                              //         style: TextStyle(
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //     const Text(
                              //       '  or  ',
                              //       style: TextStyle(color:Colors.black),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           SmoothPageRUndere(
                              //             child: Login(),
                              //           ),
                              //         );
                              //       },
                              //       child: Text(
                              //         'Forgot Password',
                              //         style: TextStyle(
                              //             color: Colors.black,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ]),
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 88.0,
                        ),
//-------------------------------------------------------------------------------------------------------- Form 2 Login Button
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          child: RawMaterialButton(
                            fillColor: Colors.purple,
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            onPressed: () {
                              _checkTeacherExist();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
