import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String? profileImageUrl; // Assuming this is the link to the image in Firebase Storage

  @override
  void initState() {
    super.initState();
    _loadImage(); // Call the function to load the initial image when the page is loaded
  }

  Future<void> _loadImage() async {
    // Fetch the user data from Firestore
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc('Image').get();

    // Get the profile image URL from Firestore
    setState(() {
      profileImageUrl = userSnapshot['Image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: profileImageUrl != null ? CachedNetworkImageProvider(profileImageUrl!) : null,
            child: profileImageUrl == null ? Icon(Icons.person, size: 80) : null,
          ),
          SizedBox(height: 20),
          // Add other profile information widgets here
        ],
      ),
    );
  }
}
