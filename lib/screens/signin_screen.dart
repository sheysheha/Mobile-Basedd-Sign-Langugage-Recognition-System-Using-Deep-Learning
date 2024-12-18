import 'package:aslr/reusable_widgets/reusable_widget.dart';
import 'package:aslr/screens/home_screen.dart';
import 'package:aslr/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:  const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 77, 31, 161),
            Color.fromARGB(255, 148, 87, 189),
            Color.fromARGB(255, 233, 101, 200)
            
            
      // hexStringToColor("CB2B93"),
      // hexStringToColor("9546C4"),
      // hexStringToColor("5E61F4")
      ],begin: Alignment.topCenter, end: Alignment.bottomCenter )),
       child: SingleChildScrollView(
         child: Padding(
           padding:EdgeInsets.fromLTRB(
             20, MediaQuery.of(context).size.height* 0.2, 20, 0),
           child: Column(
             children: <Widget>[
               logoWidget("images/logo1.webp"),
               reUsableTextField("Enter UserName", Icons.person_outline, false, _emailTextController),
               const SizedBox(
                 height: 20,
               ),
               reUsableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
               signInSignUpButton(context, true, () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, 
                  password: _passwordTextController.text).then((value){
                     Navigator.push(context, 
                       MaterialPageRoute(builder: (context)=> const HomeScreen()));
                  }).onError((error, stackTrace) {
                   print("Error ${error.toString()}");
                  });
              
               }),
               signUpOption()
               ],
             ),
           ),
         ),
      ),
    );
  }
  
   Row signUpOption() {
     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         const Text("Don't have account?",
           style: TextStyle(color: Colors.white70)),
         GestureDetector(
           onTap: (){
             Navigator.push(context,
             MaterialPageRoute(builder: (context)=>  const SignUpScreen()));
           },
           child: const Text(
             "Sign Up",
             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
           ),
         )
       ],
     );
   }
    
}