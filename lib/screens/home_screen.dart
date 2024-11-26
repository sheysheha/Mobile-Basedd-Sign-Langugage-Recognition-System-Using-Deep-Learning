import 'package:aslr/reusable_widgets/reusable_widget.dart';
import 'package:aslr/screens/RealTimeDetection.dart';
import 'package:aslr/screens/alphabet.dart';
import 'package:aslr/screens/camera_service.dart';


import 'package:aslr/screens/profile_screen.dart';
import 'package:aslr/screens/quiz_game.dart';
import 'package:aslr/screens/signRec.dart';

import 'package:aslr/screens/speech_screen.dart';
import 'package:aslr/screens/speech_to_text.dart';
import 'package:aslr/screens/spelling_bee_screen.dart';
import 'package:aslr/screens/welcome_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:aslr/screens/signin_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height, width;
  

  List imgData = [
    "images/hand.png",
    "images/gmic.png",
    "images/man.png",
    "images/a-z.png",
    "images/quiz.png",
    "images/bee.png",

  
  ];

  List titles = [
    "Sign recognition",
    "G Speech Recognition",
    "Speech recognition",
    "Alphabet",
    "Quiz",
    "Spelling Bee",
  ];
  
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 77, 31, 161),
            Color.fromARGB(255, 148, 87, 189),
            Color.fromARGB(255, 233, 101, 200)
      
          ],
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter )
        ),
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Welcome())
                            );
                          },
                          child: const Icon(
                            Icons.sort,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            size: 40,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileViewScreen()),
                            );
                              print("Container tapped");
                            },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            image: const DecorationImage(
                              image: AssetImage("images/pro.png"),
                            ),
                          ),
                        ),
                       ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 3,
                      left: 25,
                      right: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 100, // Adjust the height as needed
                          width: 225, // Adjust the width as needed
                          child: logoWidget("images/logo1.webp"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignInScreen()),
                            );
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     top: 0,
                  //     left: 20,
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //     // SizedBox(
                  //     //   height: 40, // Adjust the height as needed
                  //     //   width: 40, // Adjust the width as needed
                  //     //   child: logoWidget("images/logo1.webp"),
                  //     // ),
                  //         Text(
                  //         " Welcome to SignPal",
                  //         style: TextStyle(
                  //           fontSize: 15,
                  //           fontFamily: 'Schyler',
                  //           color: Colors.white,
                  //           //fontWeight: FontWeight.w500,
                  //           letterSpacing: 1,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: height * 0.75,
                width: width,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  SignRecScreen()),
                                  //GestureRecognition(camera: cameras[0],)),
                                  //RealTimeDetection(cameras: [],)),
                                );
                                break;
                              //  cases for other grid items here
                               case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                );
                                break;
                               case 2:
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => HomeSpeech()),
                                 );
                                break;
                                 case 3:
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => Alphabet()),
                                 );
                                break;
                               
                                case 4:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AlphabetQuiz()),
                                );
                                break;
                                case 5:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SpellingBee()),
                                );
                                break;
                              default:
                                // Handle the default case if needed
                                break;
                            }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 2,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              imgData[index],
                              width: 120, // Adjust width according to your requirement
                            ),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Rakkas',
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
