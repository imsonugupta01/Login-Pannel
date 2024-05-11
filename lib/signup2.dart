import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/loginpage.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  File? pickedImage;

  signUp(String email,String password) async{
   // print("${email} + ${password}" );
    if(email=="" || password=="" || pickedImage==null)
      {

        return UiHelper.CustomAlertBox((context), "Enter Required Field");
      }
    else {
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
           AlertDialog(
            title: Text("Email Password Signed Up"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Ok"))
            ],

          );
          uploadData();
        });
      }
      on FirebaseAuthException catch(ex)
    {
       log(ex.code.toString());
       return AlertDialog(
         title: Text("Email Password SignUp Fail"),
         actions: [
           TextButton(onPressed: (){
             Navigator.pop(context);
           }, child: Text("Ok"))
         ],

       );


    }
    }
  }

  uploadData() async
  {

    UploadTask uploadTask=FirebaseStorage.instance.ref("Profile Pics").child( emailController.text.toString() ).putFile(pickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String url=await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("Users").doc( emailController.text.toString() ).set(
        {
      "Email":emailController.text.toString(),
      "Image":url
        }).then((value){
          //log("user uploaded");
        UiHelper.CustomAlertBox(context, "Done");
       return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    });
    
    
  }
  
  showAlertBox(){
    return showDialog(context: context, builder: (BuildContext context)
    {   return AlertDialog(
      title: Text("Pick Image From"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: (){
              pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
            leading: Icon(Icons.camera),
            title: Text("Camera"),
          ),
          ListTile(
            onTap: (){
              pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
            leading: Icon(Icons.image),
            title: Text("Gallery"),
          )
        ],
      ),
    );

    });
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              showAlertBox();
            },
            child: pickedImage!=null? CircleAvatar(
              radius: 80,
              //child: Icon(Icons.person,size: 80,),
              backgroundImage: FileImage(pickedImage!),

            ):
              CircleAvatar(
                radius: 80,
                child: Icon(Icons.person,size: 80,),

              )
          ),
          UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
          UiHelper.CustomTextField(passwordController, "Password", Icons.password,false),
          SizedBox(height: 20,),
          UiHelper.customButton(() {
            signUp(emailController.text.toString() , passwordController.text.toString());
          }, "SignUp")
        ],
      ),
    );
  }
  pickImage(ImageSource imageSource) async {
    try{
      final photo=await ImagePicker().pickImage(source: imageSource);
      if(photo==null)
        return;
      final tempImage=File(photo.path);
      setState(() {
           pickedImage=tempImage;
      });
    }
    catch(ex){
        log(ex.toString());
    }
  }
}
