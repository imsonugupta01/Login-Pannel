import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/loginpage.dart';
import 'package:firebase_series/showdata.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {

  const AddData({super.key,required this.gmail});
  final String gmail;

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController NameController=TextEditingController();
  TextEditingController AddressController=TextEditingController();

  addData(String Name,String Address) async{
    if(Name=="" || Address=="")
      {
        return UiHelper.CustomAlertBox(context, "Fill Required Data");
      }
    else{
      FirebaseFirestore.instance.collection("Users2").doc(Name).set({
        "Name":Name,
        "Address":Address,
        "Ghar":Address,
      }).then((value){
       // UiHelper.CustomAlertBox(context, "Data Added");
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowData(gmail: widget.gmail)));
      //return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowData()));
      // return Navigator.pop(context);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Seller'),
        centerTitle: true,
      ),
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.gmail}"),
            TextField(
              controller: NameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                suffixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                )
              ),
            ),

            SizedBox(height: 25,),
            TextField(
              controller: AddressController,
              decoration: InputDecoration(
                  hintText: "Enter Address",
                  suffixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
              ),
            ),
            
            SizedBox(height: 25,),
            
           UiHelper.customButton(() { 
             addData(NameController.text.toString(), AddressController.text.toString());
           }, "Add")
          ],
        ),
      ),
    );
  }
}
