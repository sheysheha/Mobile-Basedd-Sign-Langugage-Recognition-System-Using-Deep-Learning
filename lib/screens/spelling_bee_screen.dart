import 'package:flutter/material.dart';
import 'dart:math';

class SpellingBee extends StatefulWidget {
  const SpellingBee({super.key});

  @override
  State<SpellingBee> createState() => _SpellingBeeState();
}

class _SpellingBeeState extends State<SpellingBee> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spelling Bee'),
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
        child: Column(
          children: [
            SizedBox(height: 60),
            Text(
              'Spelling Bee',
              style: TextStyle(
                fontSize: 75.0,
                fontFamily: 'Rakkas',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Image.asset("images/spell.jpg"),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity, // Adjust the width as needed
              height: 60.0, // Adjust the height as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(imgData: imgData, titles: titles),
                    ),
                  );
                },
                child: Text(
                  "Start Game",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final List<String> imgData;
  final List<String> titles;

  const QuizScreen({Key? key, required this.imgData, required this.titles})
      : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> words = ["CAT", "DOG", "FISH", "BIRD", "MOUSE"];
  int level = 0;
  String currentWord = "";
  List<String> userAnswer = [];
  List<String> shuffledImgData = [];
  List<String> shuffledTitles = [];

  @override
  void initState() {
    super.initState();
    currentWord = words[level];
    shuffleImages();
  }

  void shuffleImages() {
    List<int> indices = List<int>.generate(widget.imgData.length, (index) => index);
    indices.shuffle(Random());
    shuffledImgData = indices.map((index) => widget.imgData[index]).toList();
    shuffledTitles = indices.map((index) => widget.titles[index]).toList();
  }

  void checkAnswer() {
    if (userAnswer.join() == currentWord) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correct!")),
      );
      setState(() {
        if (level < words.length - 1) {
          level++;
          currentWord = words[level];
          userAnswer.clear();
          shuffleImages();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("You've completed all levels!")),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Try again!")),
      );
      userAnswer.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spell the Word'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Level ${level + 1}: Spell $currentWord",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: currentWord.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: currentWord.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            userAnswer.length > index ? userAnswer[index] : "",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    },
                    onAccept: (data) {
                      setState(() {
                        if (userAnswer.length < currentWord.length) {
                          userAnswer.add(data);
                        }
                        if (userAnswer.length == currentWord.length) {
                          checkAnswer();
                        }
                      });
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: shuffledTitles.map((title) {
                int index = shuffledTitles.indexOf(title);
                return Draggable<String>(
                  data: title,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(shuffledImgData[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  feedback: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(shuffledImgData[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SpellingBee(),
  ));
}

// import 'package:flutter/material.dart';
// import 'dart:math';

// class SpellingBee extends StatefulWidget {
//   const SpellingBee({super.key});

//   @override
//   State<SpellingBee> createState() => _SpellingBeeState();
// }

// class _SpellingBeeState extends State<SpellingBee> {
//   List<String> imgData = [
//     "images/A.png", "images/B.png", "images/C.png", "images/D.png", "images/E.png",
//     "images/F.png", "images/G.png", "images/H.png", "images/I.png", "images/J.png",
//     "images/K.png", "images/L.png", "images/M.png", "images/N.png", "images/O.png",
//     "images/P.png", "images/Q.png", "images/R.png", "images/S.png", "images/T.png",
//     "images/U.png", "images/V.png", "images/W.png", "images/X.png", "images/Y.png", "images/Z.png",
//   ];

//   List<String> titles = [
//     "A", "B", "C", "D", "E",
//     "F", "G", "H", "I", "J",
//     "K", "L", "M", "N", "O",
//     "P", "Q", "R", "S", "T",
//     "U", "V", "W", "X", "Y", "Z",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Spelling Bee'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 77, 31, 161),
//               Color.fromARGB(255, 148, 87, 189),
//               Color.fromARGB(255, 233, 101, 200),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(
//                 top: 60,
//                 left: 10,
//                 right: 15,
//                 bottom: 0,
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     'Welcome to',
//                     style: TextStyle(
//                       fontSize: 75.0,
//                       fontFamily: 'Rakkas',
//                       color: Colors.white,
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 130,
//                   //   width: 200,
//                   //   child: Image.asset("images/logo1.webp"),
//                   // ),
//                 ],
//               ),
//             ),
//             // Align(
//             //   alignment: Alignment.topRight,
//             //   child: Padding(
//             //     padding: const EdgeInsets.only(right: 15.0),
//             //     child: Text(
//             //       'Spelling Bee',
//             //       style: TextStyle(
//             //         fontSize: 22.0,
//             //         fontFamily: 'Rakkas',
//             //         color: Colors.white,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             SizedBox(height: 20),
//             Container(
//               alignment: Alignment.center,
//               child: Image.asset("images/spell.jpg"),
//             ),
//              SizedBox(height: 50),
//             Container(
//               alignment: Alignment.center,
              
//             ),
//             SizedBox(
//               width: double.infinity, // Adjust the width as needed
//               height: 60.0, // Adjust the height as needed
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => QuizScreen(imgData: imgData, titles: titles),
//                     ),
//                   );
//                 },
//                 child: Text(
//                   "Start Game",
//                   style: TextStyle(fontSize: 20.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuizScreen extends StatefulWidget {
//   final List<String> imgData;
//   final List<String> titles;

//   const QuizScreen({Key? key, required this.imgData, required this.titles})
//       : super(key: key);

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   List<String> words = ["CAT", "DOG", "FISH", "BIRD", "MOUSE"];
//   int level = 0;
//   String currentWord = "";
//   List<String> userAnswer = [];
//   List<String> shuffledImgData = [];
//   List<String> shuffledTitles = [];

//   @override
//   void initState() {
//     super.initState();
//     currentWord = words[level];
//     shuffleImages();
//   }

//   void shuffleImages() {
//     List<int> indices = List<int>.generate(widget.imgData.length, (index) => index);
//     indices.shuffle(Random());
//     shuffledImgData = indices.map((index) => widget.imgData[index]).toList();
//     shuffledTitles = indices.map((index) => widget.titles[index]).toList();
//   }

//   void checkAnswer() {
//     if (userAnswer.join() == currentWord) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Correct!")),
//       );
//       setState(() {
//         if (level < words.length - 1) {
//           level++;
//           currentWord = words[level];
//           userAnswer.clear();
//           shuffleImages();
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("You've completed all levels!")),
//           );
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Try again!")),
//       );
//       userAnswer.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Spell the Word'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 77, 31, 161),
//               Color.fromARGB(255, 148, 87, 189),
//               Color.fromARGB(255, 233, 101, 200),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Level ${level + 1}: Spell $currentWord",
//               style: TextStyle(fontSize: 24, color: Colors.white),
//             ),
//             SizedBox(height: 20),
//             GridView.builder(
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: currentWord.length,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 1,
//               ),
//               itemCount: currentWord.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DragTarget<String>(
//                     builder: (context, candidateData, rejectedData) {
//                       return Container(
//                         color: Colors.white,
//                         child: Center(
//                           child: Text(
//                             userAnswer.length > index ? userAnswer[index] : "",
//                             style: TextStyle(fontSize: 24),
//                           ),
//                         ),
//                       );
//                     },
//                     onAccept: (data) {
//                       setState(() {
//                         if (userAnswer.length < currentWord.length) {
//                           userAnswer.add(data);
//                         }
//                         if (userAnswer.length == currentWord.length) {
//                           checkAnswer();
//                         }
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             Wrap(
//               spacing: 10,
//               children: shuffledTitles.map((title) {
//                 int index = shuffledTitles.indexOf(title);
//                 return Draggable<String>(
//                   data: title,
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(shuffledImgData[index]),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   feedback: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage(shuffledImgData[index]),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   childWhenDragging: Container(
//                     width: 50,
//                     height: 50,
//                     color: Colors.grey,
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: SpellingBee(),
//   ));
// }
