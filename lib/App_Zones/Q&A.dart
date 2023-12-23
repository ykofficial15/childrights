import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MCQScreen extends StatefulWidget {
  @override
  _MCQScreenState createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  final CollectionReference mcqCollection =
      FirebaseFirestore.instance.collection('MCQ');
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool? isAnswerCorrect;
  int totalPoints = 0; // Variable to store total points.
  bool optionsDisabled = false; // Flag to disable options after selecting one.
  bool isNextButtonDisabled =
      true; // Flag to disable the "Next Question" button.
  final ConfettiController _controller =
      ConfettiController(); //duration: Duration(seconds: 1)

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: mcqCollection.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.purple,
          ));
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
        if (currentQuestionIndex < documents.length) {
          final questionData =
              documents[currentQuestionIndex].data() as Map<String, dynamic>;
          final correctAnswer =
              questionData['Opt5'] ?? ''; // Provide a default value

          return Scaffold(
            body: SingleChildScrollView(
              //--------------------------------------------------------------------------background image by yogesh
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-----------------------------------------------------------------------------------logo image by yogesh
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
                            child: Text(
                              'Q&A',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    //------------------------------------------------------------------------------------------question by yogesh
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        questionData['Question'] ?? '',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration:
                              TextDecoration.none, // Remove text decoration.
                        ),
                      ),
                    ),
                    //--------------------------------------------------------------------------------------------------options begin from here
                    Column(
                      children: List<Widget>.generate(4, (index) {
                        final option = questionData['Opt${index + 1}'] ??
                            ''; // Provide a default value
                        return GestureDetector(
                          onTap: () {
                            if (!optionsDisabled) {
                              setState(() {
                                selectedOption = option;
                                isAnswerCorrect = (option == correctAnswer);
                                optionsDisabled =
                                    true; // Disable options after selection.
                                isNextButtonDisabled =
                                    false; // Enable the "Next Question" button.

                                // Check if the answer is correct and update the points.
                                if (isAnswerCorrect == true) {
                                  totalPoints++;
                                }
                              });
                            }
                          },
                          //------------------------------------------------------------------options coloring and styling by yogesh
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            color: selectedOption == option
                                ? (isAnswerCorrect == true
                                    ? Colors.green
                                    : Colors.red)
                                : Colors.white,
                            child: Text(
                              '- ' + option,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //-----------------------------------------------------------------------next question button
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: isNextButtonDisabled
                              ? MaterialStateProperty.all(
                                  Colors.grey) // Disable color (grey)
                              : MaterialStateProperty.all(
                                  Colors.purple), // Enable color (purple)
                        ),
                        onPressed: isNextButtonDisabled
                            ? null // Disable the button if no option is selected.
                            : () {
                                setState(() {
                                  // Reset selected option and answer correctness.
                                  selectedOption = null;
                                  isAnswerCorrect = null;
                                  optionsDisabled =
                                      false; // Enable options for the next question.
                                  isNextButtonDisabled =
                                      true; // Disable the "Next Question" button again.

                                  // Move to the next question.
                                  currentQuestionIndex++;
                                  _controller.play();
                                });
                              },
                        child: Text('Next Question',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ConfettiWidget(
                      confettiController: _controller,
                      blastDirection: 3.14, // downward explosion
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      colors: const [Colors.red, Colors.blue, Colors.green],
                    ),
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
                            child: Text(
                              'Result',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    Center(
                      child: Text(
                        'All questions answered.',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Total Points: $totalPoints',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ), // Display total points.
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
