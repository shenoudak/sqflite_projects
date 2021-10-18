import 'package:flutter/material.dart';

class DoneTaskScreen extends StatelessWidget
{
  const DoneTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return const Center(
      child: Text('Done Task Screen',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),),
    );
  }
}