import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  
  final String text;
  
  const NoDataWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/no_items.png'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(text)
        )
      ],
    );
  }
}