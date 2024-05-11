import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 100,top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 100),
            Container(

            ),
            // CircleAvatar(
            //   radius: 80,
            //   child: Icon(Icons.abc),
            // )
          ],
        ),
      ),
    );
  }
}
