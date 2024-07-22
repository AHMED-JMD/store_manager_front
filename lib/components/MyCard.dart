import 'package:flutter/material.dart';
import 'package:store_manager/components/Formatters.dart';

class MyCard extends StatelessWidget {
  final double width_num;
  final double height_num;
  final double title;
  final String subtitle;
  final Widget? Icon;

   const MyCard({
    super.key,
    required this.width_num,
    required this.height_num,
    required this.title,
    required this.subtitle,
     this.Icon
  });

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Container(
      width: _width/width_num,
      height: _height/height_num,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  moneyFormatter(title),
                  style: TextStyle(fontSize: 44, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10,),
                if(Icon != null)
                  Icon ?? const SizedBox()
              ],
            ),
            Text('$subtitle', style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}
