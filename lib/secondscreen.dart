import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111731),
      body: Center(
          child: Row(
        children: [
          Flexible(
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.white)),
            flex: 1,
          ),
          Flexible(
            child: Container(),
            flex: 3,
          ),
          Flexible(
            child: Container(),
            flex: 3,
          ),
          Flexible(
            child: Container(),
            flex: 1,
          ),
        ],
      )),
    );
  }
}
