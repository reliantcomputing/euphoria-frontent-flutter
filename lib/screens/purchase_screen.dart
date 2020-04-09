import 'package:flutter/material.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          title: Text("Checkout"),
          centerTitle: true,
          elevation: 1,
        ),
      body: Center(
        child: Text("To be implemented, waiting payfast auth keys"),
      ),
    );
  }
}