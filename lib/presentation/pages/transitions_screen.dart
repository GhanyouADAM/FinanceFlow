import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionsScreen extends StatefulWidget {
  const TransitionsScreen({super.key});

  @override
  State<TransitionsScreen> createState() => _TransitionsScreenState();
}

class _TransitionsScreenState extends State<TransitionsScreen> {

  @override
  void initState() async {
      Future.delayed(Duration(milliseconds: 3000));
    context.goNamed('home');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('This is the launching screen'),),
    );
  }
}