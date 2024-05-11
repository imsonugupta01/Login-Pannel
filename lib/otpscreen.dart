

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/main.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final verificationid;
  const OtpScreen({super.key,required this.verificationid});


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController OTPController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25 ),
            child: TextField(
              controller: OTPController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                )
              ),

            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: ()async{
            try{

              PhoneAuthCredential credential=
              await PhoneAuthProvider.credential(
                  verificationId:widget.verificationid,
                  smsCode:OTPController.text.toString());
              FirebaseAuth.instance.signInWithCredential(credential).then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "HomePage")));
              });
            }
            catch(ex){
               log(ex.toString());
            }

          }, child: Text("OTP")),
        ],
      ),
    );
  }
}
