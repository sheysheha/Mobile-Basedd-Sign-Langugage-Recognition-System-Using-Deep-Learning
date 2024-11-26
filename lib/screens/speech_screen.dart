import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';


class HomeSpeech extends StatefulWidget {
  const HomeSpeech({super.key});

  @override
  State<HomeSpeech> createState() => __HomeSpeechState();
}

class __HomeSpeechState extends State<HomeSpeech> {
  SpeechToText _speech = SpeechToText();
  String _recognizedText = "";
  bool _isListening =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeechState();
  }
  
  void _initSpeechState() async {
    bool available = await _speech.initialize();
    if(!mounted) return;
    setState(() {
      _isListening = available;
    });
   }

   void _startListening(){
    _speech.listen(
      onResult: (result){
        setState(() {
          _recognizedText = result.recognizedWords;
           });
      }
    );
    setState(() {
      _isListening =true;
    });
   Future.delayed(Duration(minutes: 2), () {
      if (_isListening) {
        _speech.stop();
        setState(() {
          _isListening = false;
        });
      }
    });
  }

   void _copyText(){
    Clipboard.setData(ClipboardData(text: _recognizedText));
    _showSnackBar("Text Copied");
   }
   void _clearText(){
    setState(() {
      _recognizedText="";
  
    });
   }

   void _showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
      duration: Duration(seconds: 1),
      )
    );
   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Speech Recognition'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(
              "Speech Recognition",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
          ),
          SizedBox(height: 40),
          IconButton(
            onPressed: _startListening,
           icon: Icon(_isListening? Icons.mic :Icons.mic_none),
          iconSize: 100,
          color: _isListening? Colors.red :Colors.grey
          ),
          const SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height/4,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _recognizedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
              ),),
          ),
          const SizedBox(
            height: 20
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: _recognizedText.isNotEmpty? _copyText: null,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child:  Text(
              //       "Copy",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         )
              //     ),
                  
              //     ),
              // ),
    
              const SizedBox(
               width: 20),
              InkWell(
                onTap: _recognizedText.isNotEmpty? _clearText: null,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Text(
                    "Clear",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      )
                  ),
                  
                  ),
              )
            ],
          )
        ]
        ),
        
      ),
    );

  }
}