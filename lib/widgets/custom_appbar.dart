import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Q',
          style: TextStyle(
            color: Colors.redAccent[200],
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'U',
          style: TextStyle(
            color: Colors.green[300],
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'I',
          style: TextStyle(
            fontSize:40,
            fontWeight: FontWeight.bold,
            color: Colors.yellow[300],
          ),
        ),
        const Text(
          'Z',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 20,),
        Text(
          'M',
          style: TextStyle(
            color: Colors.yellow[300],
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'E',
          style: TextStyle(
            color: Colors.green[300],
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
