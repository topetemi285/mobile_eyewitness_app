import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:eyewitness_app/screens/components/textSpeechWidget.dart';
import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToText extends StatefulWidget {
  const SpeechToText({ Key key }) : super(key: key);

  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}
class _SpeechToTextState extends State<SpeechToText> {
  String text ="Press the bbutton and start speaking";
  bool isListening=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SPEECH TO TEXT"),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context)=>IconButton(
              onPressed: ()async
              {
                await FlutterClipboard.copy(text);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('COPIED TO CLIPBOARD'),
                    ),
                  );
              }, 
              icon: Icon(Icons.content_copy)),
          )
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(30.0).copyWith(bottom: 150),
          child: Text(
            text, 
            style: TextStyle(
              fontSize: 30,
              color:Colors.black,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening, 
        endRadius: 75,
        glowColor: Theme.of(context).primaryColor,
        child: FloatingActionButton(
          onPressed: toggleRecording,
         child: Icon(isListening
           ?Icons.mic
           :Icons.mic_none,
           size: 36,
           ),
          ),
      ),  
    );
  }
  Future toggleRecording()=>SpeechApi.toggleRecording(
    onResult: (text)=>setState(()=>this.text=text),
    onListen: (isListening){
      setState(()=>this.isListening=isListening);
    }
    );
}




// class SpeechApi{
//   static final _speech = SpeechToText();

//   static Future<bool> toggleRecording({
//     @required Function(String text) onResult,
//     @required ValueChanged<bool> onListening,
//   }) async{
//     if(_speech.isListening){
//       _speech.stop();
//       return true;
//     }
//     final isAvailable = await _speech.initialize(
//       onStatus: (status)=> onListening(_speech.isListening,),
//       onError: (e)=>print("Error: $e")
//     );
//     if(isAvailable){
//       _speech.listen(
//         onResult: (value)=> onResult(value.recognizedWords));
//     }
//     return isAvailable;
//   }
// }