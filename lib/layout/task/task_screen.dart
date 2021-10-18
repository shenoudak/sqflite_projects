import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class NewTaskScreen extends StatelessWidget
{
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return const Center(
      child: Text('New Task Screen',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),),
    );
  }

}