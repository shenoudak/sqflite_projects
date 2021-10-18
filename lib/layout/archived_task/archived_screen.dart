import 'package:flutter/material.dart';

class ArchivedTaskScreen extends StatelessWidget
{
  const ArchivedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return const Center(
      child: Text('Archived Task Screen',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),),
    );
  }
}
