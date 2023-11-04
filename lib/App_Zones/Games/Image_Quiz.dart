import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> currentQuestion = {};
  bool isButtonEnabled = false;
  bool hasAnswerBeenSelected = false;
  bool isAnswerCorrect = false;
  String selectedOption = '';
  int currentQuestionIndex = 0;
  QuerySnapshot? questionSnapshot;

  @override
  void initState() {
    super.initState();
    _fetchQuestion();
  }

  Future<void> _fetchQuestion() async {
    if (questionSnapshot == null ||
        currentQuestionIndex >= questionSnapshot!.docs.length) {
      questionSnapshot = await _firestore.collection('imagequiz').get();
      currentQuestionIndex = 0;
    }

    if (questionSnapshot!.docs.isNotEmpty) {
      final question = questionSnapshot!.docs[currentQuestionIndex].data()
          as Map<String, dynamic>;
      setState(() {
        currentQuestion = question;
        isButtonEnabled = false;
        hasAnswerBeenSelected = false;
        isAnswerCorrect = false;
        selectedOption = '';
        currentQuestionIndex++;
      });
    }
  }

  Future<void> checkAndProceed(bool isOpt1) async {
    if (!hasAnswerBeenSelected) {
      bool isCorrect = false;
      if (isOpt1 && currentQuestion['Opt1'] == currentQuestion['Opt3']) {
        isCorrect = true;
      } else if (!isOpt1 &&
          currentQuestion['Opt2'] == currentQuestion['Opt3']) {
        isCorrect = true;
      }

      setState(() {
        isAnswerCorrect = isCorrect;
        hasAnswerBeenSelected = true;
        isButtonEnabled = true;
        selectedOption = isOpt1 ? 'Opt1' : 'Opt2';
      });

      if (!isAnswerCorrect) {
        _showWrongAnswerDialog();
      }
    }
  }

  void _showWrongAnswerDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Wrong Answer!',
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              currentQuestion['Opt4'],
              style: TextStyle(color: const Color.fromARGB(255, 0, 116, 4)),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _fetchQuestion();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Next Question',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          );
        });
  }

  void onNextQuestion() {
    _fetchQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        //------------------------------------------------------------------------background image
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/bg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //---------------------------------------------------------------------------------logo
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/splash.png',
                    height: 150, width: 150, alignment: Alignment.centerLeft),
              ),
              //-----------------------------------------------------------------------------thoda sa spacing swaad anusaar
              SizedBox(
                height: 120,
              ),
              //-----------------------------------------------------------------------------------questions
              Container(
                child: Text(
                  currentQuestion?['Question'] ?? 'Loading...',
                  style: TextStyle(
                      color: Colors.purple,
                      decoration: TextDecoration.none,
                      fontSize: 25),
                ),
              ),
              //--------------------------------------------------------------------thoda or spacing swaad anusaar
              SizedBox(
                height: 50,
              ),
              //----------------------------------------------------------------------------options in image format
              Container(
  width: MediaQuery.of(context).size.width,
  padding: EdgeInsets.all(5),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            checkAndProceed(true);
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                ),
              ],
              border: Border.all(
                color: selectedOption == 'Opt1'
                    ? (isAnswerCorrect ? Colors.green : Colors.red)
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: currentQuestion['Opt1'] == null
                ?  Center(child:CircularProgressIndicator(color:Colors.purple))  // Display a loader if Opt1 is null
                : Image.network(
                    currentQuestion['Opt1'],
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            checkAndProceed(false);
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                ),
              ],
              border: Border.all(
                color: selectedOption == 'Opt2'
                    ? (isAnswerCorrect ? Colors.green : Colors.red)
                    : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: currentQuestion['Opt2'] == null
                ? Center(child:CircularProgressIndicator(color:Colors.purple)) // Display a loader if Opt2 is null
                : Image.network(
                    currentQuestion['Opt2'],
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    ],
  ),
),

//-------------------------------------------------------------------------------------------thodi si height swaad anusaar
              SizedBox(
                height: 80,
              ),
//------------------------------------------------------------------------------------------next button for the new question
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          isButtonEnabled ? Colors.purple : Colors.grey)),
                  onPressed: isButtonEnabled ? onNextQuestion : null,
                  child: Text('Next Question'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
