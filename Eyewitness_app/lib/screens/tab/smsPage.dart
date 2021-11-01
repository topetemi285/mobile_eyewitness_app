import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';


class SmsFile extends StatefulWidget {
  const SmsFile({ Key key }) : super(key: key);

  @override
  _SmsFileState createState() => _SmsFileState();
}

class _SmsFileState extends State<SmsFile> {
final Telephony telephony = Telephony.instance;

final _formKey = GlobalKey<FormState>();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _msgController = TextEditingController();
final TextEditingController _valuesms = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Message"),
        actions: [],),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value){
                      if(value==null){
                        return "enter phone number";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "PHONE Number",
                      hintText: "Enter phone Number",

                    ),
                  ),
                ),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                    controller: _msgController,
                    validator: (value){
                      if(value==null){
                        return "enter Message";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Message",
                      hintText: "Enter message",

                    ),
                  ),
               ),

              //  Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: TextFormField(
              //       controller: _valuesms,
              //       keyboardType: TextInputType.number,
              //       validator: (value){
              //         if(value==null){
              //           return "enter Value";
              //         }
              //         return null;
              //       },
              //       decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         labelText: "Message",
              //         hintText: "Enter Value",

              //       ),
              //     ),
              //  ),

               ElevatedButton(
                 onPressed: ()async{
                   try{
                     sendMsg();
                   }catch(e){
                     print(e.toString());
                   }
                   
                  //print("object");
                 },
                 

                 child: Text("Send")
                 ),

                // ElevatedButton(
                //   onPressed: ()=>getSms,
                //  child: Text("Recieve"),
                //   )

              ],
            ),
          ),
          ),
       
      ),
    );
  }
  sendMsg()async{
    int _sms = 0;
    while(_sms<int.parse(_valuesms.text)){
      telephony.sendSms(to: _phoneController.text, message: _msgController.text);
      _sms++;
    }
  }
  // getSms()async{
  //   List<SmsMessage> _message = await telephony.getInboxSms(
  //     columns: [
  //       SmsColumn.ADDRESS,SmsColumn.BODY,SmsColumn.DATE_SENT
  //     ],
  //     filter: SmsFilter.where(SmsColumn.ADDRESS).equals(_phoneController.text),
  //   );
  //   for(var msg in _message){
  //     print(msg);
  //   }
  // }
}