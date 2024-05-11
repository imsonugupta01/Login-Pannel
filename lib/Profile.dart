import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/adddata.dart';
import 'package:firebase_series/addproducducts.dart';
import 'package:firebase_series/loginpage.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/showdata.dart';
import 'package:firebase_series/showseller.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {




  const ProfilePage({super.key,required this.gmail });
  final String gmail;




  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //TextEditingController emailController=TextEditingController();
   logout() {

     FirebaseAuth.instance.signOut().then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 30),
      child: Column(

         children: [

           Row(
             children: [

               ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowData(gmail: widget.gmail)));
               },
                   child: Text("Products ")),
               SizedBox(width: 30,),
               ElevatedButton(onPressed: (){
                 //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                 logout();
               },
                   child: Text("Logout")),

             ],
           ),

           SizedBox(height: 20,),
           ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSeller(gmail: widget.gmail)));
           }, child: Text("Show Seller")),
           SizedBox(height: 20,),
           ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData(gmail: widget.gmail)));
           }, child: Text("Add Sellers")),

           SizedBox(height: 20,),
           ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProducts()));
           }, child: Text("Add Products")),
         ],
       ),
     ),
    );
  }
}
