import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/components/MyCard.dart';
import 'package:store_manager/components/SideBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SidebarXController controller = SidebarXController(selectedIndex: 0,);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            MySideBar(controller: controller),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 70,),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: (){},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300]
                          ),
                          icon: Icon(Icons.storage),
                          label: Text('مخزن الفلير')
                      ),
                      TextButton.icon(
                          onPressed: (){},
                          icon: Icon(Icons.storage_rounded),
                          label: Text(' اخرى')
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyCard(width_num: 4, height_num: 4.2, title: 124, subtitle: 'اجمالي مخزون الفلير'),
                      MyCard(width_num: 4, height_num: 4.2, title: 15300, subtitle: 'قيمة المخزون بالدرهم'),
                      Expanded(
                        child: MyCard(width_num: 1, height_num: 4.2, title: 14940300, subtitle: 'قيمة المخزون بالسوداني'),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      TextButton.icon(
                          onPressed: (){},
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[300]
                          ),
                          icon: Icon(Icons.point_of_sale_sharp),
                          label: Text('مبيعات الشهر')
                      ),
                    ]
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: MyCard(width_num: 1, height_num: 4.2, title: 1350114, subtitle: 'ارباح الشهر بالسوداني')
                      ),
                      MyCard(width_num: 4, height_num: 4.2, title: 2540, subtitle: 'ارباح الشهر بالدرهم'),
                      MyCard(width_num: 4, height_num: 4.2, title: 30, subtitle: 'اجمالي مبيعات الفلير'),
                    ],
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}
