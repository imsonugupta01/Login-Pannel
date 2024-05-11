import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/adddata.dart';
import 'package:firebase_series/loginpage.dart';
import 'package:firebase_series/main.dart';
import 'package:firebase_series/productspage.dart';
import 'package:firebase_series/studentprofile.dart';
import 'package:firebase_series/uihelper.dart';
import 'package:flutter/material.dart';

class ShowSeller extends StatefulWidget {
  const ShowSeller({super.key,required this.gmail});
  final String gmail;

  @override
  State<ShowSeller> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        centerTitle: true,
      ),


      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users2").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>

                                    MyHomePage(title: "${snapshot.data!.docs[index]["Name"]}",

                                      // StudentProfile();
                                    ),
                                //ProductPage(),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text("${index + 1}"),
                            ),
                            title: Text("${snapshot.data!.docs[index]["Name"]}"),
                            subtitle:
                            Text("${snapshot.data?.docs[index]["Address"]}"),
                            //trailing: Text("${snapshot.data?.docs[index]["Cost"]} /-" ),
                          ),
                        );
                      },
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData()));
                  //   },
                  //   child: Text('Add New Person'),
                  // ),
                  UiHelper.customButton(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData(gmail: widget.gmail)));
                  }, "Add New")
                ],
              );
            } else {
              // Handle the case when there is no data
              return Center(child: Text("No data available"));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.hasError.toString()}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),


    );
  }
}


//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class ShowData extends StatefulWidget {
//   const ShowData({Key? key}) : super(key: key);
//
//   @override
//   State<ShowData> createState() => _ShowDataState();
// }
//
// class _ShowDataState extends State<ShowData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Show Data"),
//         centerTitle: true,
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection("Users").doc("kumarsonu94047@gmail.com").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               // Extract user data from the document
//               var userData = snapshot.data!;
//
//               return ListTile(
//                 leading: CircleAvatar(
//                   child: Text("1"),
//                 ),
//                 title: Text("${userData["Email"]}"),
//                 subtitle: Text("${userData["Name"]}"),
//               );
//             } else {
//               // Handle the case when there is no data
//               return Center(child: Text("No data available"));
//             }
//           } else if (snapshot.hasError) {
//             // Handle the case when there is an error
//             return Center(child: Text("${snapshot.error.toString()}"));
//           } else {
//             // Show a loading indicator while waiting for data
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
