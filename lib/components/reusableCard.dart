import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  final title;
  final data;
  MyColumn({@required this.title, @required this.data});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.toString()),
              Text(data.toString()),
            ],
          ),
          Divider(
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
