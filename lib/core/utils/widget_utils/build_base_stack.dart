import 'package:flutter/material.dart';

class BuildBaseStack extends StatelessWidget {
  final Widget basePageBody;

  const BuildBaseStack({Key? key, required this.basePageBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Transform.scale(
            scale: 1.85,
            child: Image.asset(
              'assets/a9acb153c6387b54853328da0c1655cb.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        basePageBody,
      ],
    );
  }
}
