import 'package:flutter/material.dart';

Widget defaultTextFormFaield(
{
  @required TextEditingController? controller,
  @required String? label,
  IconData? perfix_icon,
  IconData? suffix_icon,
  bool ispassword=false,
  VoidCallback? isTap,
  @required String? returnIsValidator,



}
)=>Padding(
  padding: const EdgeInsets.all(10.0),
  child: TextFormField(
    onTap: isTap,
    obscureText: ispassword,
    controller: controller,
    decoration: InputDecoration(
      label: Text('${label}'),
      prefixIcon: Icon(perfix_icon),
      suffixIcon: ispassword?Icon(suffix_icon):null,
      border: OutlineInputBorder(),
    ),
    validator: (value){
      if(value!.isEmpty)
      return returnIsValidator;
      else
        return null;

    },
  ),
);