import 'package:flutter/material.dart';
import 'dart:math';

class AlphabetQuiz extends StatefulWidget {
  const AlphabetQuiz({Key? key}) : super(key: key);

  @override
  State<AlphabetQuiz> createState() => _AlphabetQuizState();
}

class _AlphabetQuizState extends State<AlphabetQuiz> {
  List<String> imgData = [
    "images/A.png", "images/B.png", "images/C.png", "images/D.png", "images/E.png",
    "images/F.png", "images/G.png", "images/H.png", "images/I.png", "images/J.png",
    "images/K.png", "images/L.png", "images/M.png", "images/N.png", "images/O.png",
    "images/P.png", "images/Q.png", "images/R.png", "images/S.png", "images/T.png",
    "images/U.png", "images/V.png", "images/W.png", "images/X.png", "images/Y.png", "images/Z.png",
  ];

  List<String> titles = [
    "A", "B", "C", "D", "E",
    "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O",
    "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z",
  ];

  int currentIndex = 0;
  int score = 0;
  String answerMessage = '';
  bool showAnswer = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    shuffleQuiz();
  }

  void shuffleQuiz() {
    final random = Random();
    List<Map<String, String>> pairedList = List.generate(imgData.length, (index) => {
      'image': imgData[index],
      'title': titles[index],
    });
    
    pairedList.shuffle(random);

    for (int i = 0; i < pairedList.length; i++) {
      imgData[i] = pairedList[i]['image']!;
      titles[i] = pairedList[i]['title']!;
    }
  }

  void checkAnswer() {
    setState(() {
      if (_controller.text.toUpperCase() == titles[currentIndex]) {
        score++;
        answerMessage = 'Correct!';
      } else {
        answerMessage = 'Wrong!';
      }
      showAnswer = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    setState(() {
      currentIndex = (currentIndex + 1) % imgData.length;
      showAnswer = false;
      answerMessage = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Alphabet Quiz'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 77, 31, 161),
              Color.fromARGB(255, 148, 87, 189),
              Color.fromARGB(255, 233, 101, 200),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (answerMessage.isNotEmpty)
                Text(
                  answerMessage,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: answerMessage == 'Correct!' ? Colors.green : Colors.red,
                  ),
                ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    imgData[currentIndex],
                    width: 150, // Adjust width according to your requirement
                  ),
                ),
              ),
              Text(
                showAnswer ? titles[currentIndex] : "What letter is this?",
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Rakkas',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rakkas',
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your answer',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 77, 31, 161),
                  ),
                ),
                onPressed: showAnswer ? null : checkAnswer,
                child: Text('Check Answer'),
              ),
              SizedBox(height: 20),
              Text(
                'Score: $score',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Rakkas',
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AlphabetQuiz(),
  ));
}
