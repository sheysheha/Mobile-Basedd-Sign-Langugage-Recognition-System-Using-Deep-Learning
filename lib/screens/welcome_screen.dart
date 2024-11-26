import 'package:aslr/reusable_widgets/reusable_widget.dart';
import 'package:aslr/screens/signin_screen.dart';
import 'package:aslr/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var height, width;

  @override
  Widget build(BuildContext context) {
        return  Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 77, 31, 161),
                  Color.fromARGB(255, 148, 87, 189),
                  Color.fromARGB(255, 233, 101, 200)
            ],begin: Alignment.topCenter, end: Alignment.bottomCenter )),
         child: Expanded(
          
            
                
                //   ),
              child: Column(
               children: [
                Container(
                      decoration:  BoxDecoration(
                      //color: Colors.white.withOpacity(0.5),
                      ),
                      child: Container(  
                         decoration: BoxDecoration(),
                          height: height,
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 60,
                                  left: 10,
                                  right: 15,
                                  bottom: 0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Text(
                                  'Welcome to',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontFamily: 'Rakkas',
                                    color: Colors.white,

                                  ),
                                  
                                  ),
                                  SizedBox(
                                    height: 130, // Adjust the height as needed
                                    width: 200,
                                    // Adjust the width as needed
                                    child: logoWidget("images/logo1.webp"),  
                                    )
                                  ]
                                ),
                              ),
                              SizedBox(height: 20), // Add some spacing between rows
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "images/welcome.jpeg",
                                
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    signInSignUpButton(context, true, () {
                                    
                                      Navigator.push(context, 
                                        MaterialPageRoute(builder: (context)=> const SignInScreen()));
                                    }),
                                    signInSignUpButton(context, false, () {
                                    
                                      Navigator.push(context, 
                                        MaterialPageRoute(builder: (context)=> const SignUpScreen()));
                                    })
                                  ]
                              )
                            ) 
                        ]
                      ),
                    )
                  )
                ]
              )
            )
          )
        );
  }
}


