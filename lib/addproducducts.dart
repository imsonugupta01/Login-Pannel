

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_series/Profile.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController ProductName=TextEditingController();
  TextEditingController Cost=TextEditingController();
  TextEditingController Brand=TextEditingController();
  TextEditingController Cloth=TextEditingController();
  File? pickedImage;

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

  uploadData() async
  {

    UploadTask uploadTask=FirebaseStorage.instance.ref("${Cloth.text.toString()}").child( Brand.text.toString() )   .putFile(pickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String url=await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("Shop").doc( Cloth.text.toString() ).collection("${ProductName.text.toString()}").doc("${Brand.text.toString()}").set( //.set(
        {
          // "Email":emailController.text.toString(),
          // "Image":url
            
            "Product Name":ProductName.text.toString(),
            "Cost":Cost.text.toString(),
            "Brand":Brand.text.toString()
        }).then((value){
      //log("user uploaded");

      FirebaseFirestore.instance.collection("AllClohtes").doc(Cloth.text.toString()).set(
        {
          "Product Name":ProductName.text.toString(),
          "Cost":Cost.text.toString(),
          "Brand":Brand.text.toString(),
        }
      ).then((value) => null);
      UiHelper.CustomAlertBox(context, "Done");
      Navigator.pop(context);
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilePage(gmail: "xxx")));
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Products"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 100 ,vertical: 50),
          padding: const EdgeInsets.only(left: 10,bottom: 50,top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text('Name'),
              //CircleAvatar(backgroundColor: Colors.grey,child: Text("select Image",style: TextStyle(color: Colors.white),),radius: 50,),
              InkWell(
                onTap: (){
                  showAlertBox();
                },
                //child: CircleAvatar(backgroundColor: Colors.grey,child: Text("select Image",style: TextStyle(color: Colors.white),),radius: 50,),
                  child: pickedImage!=null? CircleAvatar(
                    radius: 80,
                    //child: Icon(Icons.person,size: 80,),
                    backgroundImage: FileImage(pickedImage!),

                  ):
                  CircleAvatar(
                    radius: 80,
                    child: Icon(Icons.shopping_cart,size: 80,),

                  )
              ),
              UiHelper.CustomTextField(ProductName  , "Product Name",Icons.shopping_cart, false),
              UiHelper.CustomTextField(Cloth, "Type", Icons.shop , false),
              UiHelper.CustomTextField(Cost, "Cost", Icons.monetization_on_outlined, false),
              UiHelper.CustomTextField(Brand, "Brand" , Icons.tag ,false),
              UiHelper.customButton(() { uploadData(); }, "Upload"),




            ],
          ),
        ),
      ),
    );
  }
}
