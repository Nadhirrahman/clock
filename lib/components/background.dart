import 'package:flutter/material.dart';


class background extends StatelessWidget {
  final Widget child;
  const background({
    Key? key,
    required this.child,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return Container(
      height: sz.height,
      width: double.infinity,
      child: Stack(
        alignment: const Alignment(0.0, - 0.6),
        children: <Widget>[
          Container(
            width: 320, //260
            height: 48,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/logo.png'
                ),
                  fit: BoxFit.fill
                ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}