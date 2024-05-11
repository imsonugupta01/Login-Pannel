import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/Profile.dart';
import 'package:firebase_series/forgotpassword.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/signup2.dart';
import 'package:firebase_series/signuppage.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  login(String email,String password) async{
    if(email=="" && password=="")
      {
        return UiHelper.CustomAlertBox(context, "Enter Required Field");
      }
    else{

      UserCredential? usercredential;

      try{

        usercredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilePage(gmail: email)));
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
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
        UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
        UiHelper.CustomTextField(passwordController,"Password",Icons.password, true),
        SizedBox(height: 30),
        UiHelper.customButton(() {
          login(emailController.text.toString(), passwordController.text.toString());
        }, "Login"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already Have an Account??",style: TextStyle(fontSize: 16),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp2()));
              }, child: Text("Sign  Up",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500 ),))
            ],
          ),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassWord()));
          }, child: Text("Forgot Password"))

      ],),
    );
  }
}


//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_series/Profile.dart';
// import 'package:firebase_series/forgotpassword.dart';
// import 'package:firebase_series/main.dart';
// import 'package:firebase_series/signup2.dart';
// import 'package:firebase_series/signuppage.dart';
// import 'package:firebase_series/uihelper.dart';
// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future<void> login(String email, String password) async {
//     if (email == "" || password == "") {
//       return UiHelper.CustomAlertBox(context, "Enter Required Field");
//     } else {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: email, password: password);
//
//         // Update user's token
//         await _updateUserToken(userCredential.user!.uid);
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage(gmail: email)),
//         );
//       } on FirebaseAuthException catch (ex) {
//         return UiHelper.CustomAlertBox(context, ex.code.toString());
//       }
//     }
//   }
//
//   Future<void> _updateUserToken(String uid) async {
//     // Generate a new token (e.g., timestamp)
//     String token = DateTime.now().millisecondsSinceEpoch.toString();
//
//     // Store the token in Firestore
//     await FirebaseFirestore.instance.collection('user_tokens').doc(uid).set({
//       'token': token,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Page"),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
//           UiHelper.CustomTextField(
//               passwordController, "Password", Icons.password, true),
//           SizedBox(height: 30),
//           UiHelper.customButton(() {
//             login(emailController.text.toString(), passwordController.text.toString());
//           }, "Login"),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Already Have an Account??", style: TextStyle(fontSize: 16)),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp2()));
//                 },
//                 child: Text("Sign Up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
//               )
//             ],
//           ),
//           SizedBox(height: 20),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassWord()));
//             },
//             child: Text("Forgot Password"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_series/Profile.dart';
// import 'package:firebase_series/forgotpassword.dart';
// import 'package:firebase_series/main.dart';
// import 'package:firebase_series/signup2.dart';
// import 'package:firebase_series/signuppage.dart';
// import 'package:firebase_series/uihelper.dart';
// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future<void> login(String email, String password) async {
//     if (email == "" || password == "") {
//       return UiHelper.CustomAlertBox(context, "Enter Required Field");
//     } else {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: email, password: password);
//
//         // Update user's token
//         await _updateUserToken(userCredential.user!.uid);
//
//         // Check and logout from other devices
//         await _logoutFromOtherDevices(userCredential.user!.uid);
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage(gmail: email)),
//         );
//       } on FirebaseAuthException catch (ex) {
//         return UiHelper.CustomAlertBox(context, ex.code.toString());
//       }
//     }
//   }
//
//   Future<void> _updateUserToken(String uid) async {
//     // Generate a new token (e.g., timestamp)
//     String token = DateTime.now().millisecondsSinceEpoch.toString();
//
//     // Store the token in Firestore
//     await FirebaseFirestore.instance.collection('user_tokens').doc(uid).set({
//       'token': token,
//     });
//   }
//
//   Future<void> _logoutFromOtherDevices(String uid) async {
//     // Get the user's current token
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('user_tokens')
//         .doc(uid)
//         .get();
//
//     if (snapshot.exists) {
//      // String currentToken = snapshot.data()?['token'] ?? '';
//       String currentToken = (snapshot.data() as Map<String, dynamic>)['token'] ?? '';
//
//
//       // Delete all other tokens except the current one
//       await FirebaseFirestore.instance
//           .collection('user_tokens')
//           .where('token', isNotEqualTo: currentToken)
//           .get()
//           .then((QuerySnapshot querySnapshot) {
//         querySnapshot.docs.forEach((doc) {
//           doc.reference.delete();
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Page"),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
//           UiHelper.CustomTextField(
//               passwordController, "Password", Icons.password, true),
//           SizedBox(height: 30),
//           UiHelper.customButton(() {
//             login(emailController.text.toString(), passwordController.text.toString());
//           }, "Login"),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Already Have an Account??", style: TextStyle(fontSize: 16)),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp2()));
//                 },
//                 child: Text("Sign Up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
//               )
//             ],
//           ),
//           SizedBox(height: 20),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassWord()));
//             },
//             child: Text("Forgot Password"),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_series/Profile.dart';
// import 'package:firebase_series/forgotpassword.dart';
// import 'package:firebase_series/signup2.dart';
// import 'package:firebase_series/uihelper.dart';
// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   Future<void> login(String email, String password) async {
//     if (email == "" || password == "") {
//       return UiHelper.CustomAlertBox(context, "Enter Required Field");
//     } else {
//       try {
//         UserCredential userCredential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: email, password: password);
//
//         // Disconnect existing devices
//         await _disconnectOtherDevices(userCredential.user!.uid);
//
//         // Update user's token
//         await _updateUserToken(userCredential.user!.uid);
//
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ProfilePage(gmail: email)),
//         );
//       } on FirebaseAuthException catch (ex) {
//         return UiHelper.CustomAlertBox(context, ex.code.toString());
//       }
//     }
//   }
//
//   Future<void> _disconnectOtherDevices(String uid) async {
//     // Revoke all existing refresh tokens (disconnect all devices)
//     await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(
//       EmailAuthProvider.credential(email: FirebaseAuth.instance.currentUser!.email!, password: "dummy_password"),
//     );
//   }
//
//   Future<void> _updateUserToken(String uid) async {
//     // Generate a new token (e.g., timestamp)
//     String token = DateTime.now().millisecondsSinceEpoch.toString();
//
//     // Store the token in Firestore
//     await FirebaseFirestore.instance.collection('user_tokens').doc(uid).set({
//       'token': token,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Page"),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           UiHelper.CustomTextField(emailController, "Email", Icons.email, false),
//           UiHelper.CustomTextField(
//             passwordController,
//             "Password",
//             Icons.password,
//             true,
//           ),
//           SizedBox(height: 30),
//           UiHelper.customButton(() {
//             login(emailController.text.toString(), passwordController.text.toString());
//           }, "Login"),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Already Have an Account??", style: TextStyle(fontSize: 16)),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp2()));
//                 },
//                 child: Text("Sign Up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
//               )
//             ],
//           ),
//           SizedBox(height: 20),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassWord()));
//             },
//             child: Text("Forgot Password"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
