import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  signUp(String email,String password) async{
    if(email=="" && password=="")
      {
           UiHelper.CustomAlertBox(context,"Enter Required Fields" );
      }
    else
      {
        UserCredential? usercredential;//  ? reprents that it can be null
        try{
          usercredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "HomePage")));
          });
        }
        on FirebaseAuthException catch(ex)
          {
            return UiHelper.CustomAlertBox(context, ex.code.toString());
          }
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
          UiHelper.CustomTextField(passwordcontroller,"Password",Icons.password,true),
          SizedBox(height: 30,),
          UiHelper.customButton(() {
            signUp(emailController.text.toString(), passwordcontroller.text.toString());
          }, "Sign Up")


        ],
      ),
    );
  }
}
