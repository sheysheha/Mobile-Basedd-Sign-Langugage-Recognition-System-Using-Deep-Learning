import 'package:flutter/material.dart';

class Alphabet extends StatefulWidget {
  const Alphabet({Key? key}) : super(key: key);

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
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
        title: const Text('Sign Alphabet'),
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
      child:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          mainAxisSpacing: 25,
        ),
        itemCount: imgData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
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
                    width: 100, // Adjust width according to your requirement
                  ),
                  Text(
                    titles[index],
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rakkas',
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),)
    ));
  }
}
