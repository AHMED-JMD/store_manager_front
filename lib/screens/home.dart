import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sidebarx/sidebarx.dart';
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

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
                      Expanded(
                        child: Container(
                          height: _height/4.2,
                          child: Card(
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '12,451,987 SDG',
                                    style: TextStyle(fontSize: 44, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                                  ),
                                  Text('قيمة المخزون بالجنيه')
                                ],
                              ),
                          ),
                        ),
                      ),
                      Container(
                        width: _width/4,
                        height: _height/4.2,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '15,300 AED',
                                style: TextStyle(fontSize: 44, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                              ),
                              Text('قيمة المخزون بالدرهم')
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: _width/4,
                        height: _height/4.2,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '124',
                                style: TextStyle(fontSize: 44, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                              ),
                              Text('اجمالي مخزون الفلير')
                            ],
                          ),
                        ),
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
                      Container(
                        width: _width/4,
                        height: _height/4.2,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '30',
                                style: TextStyle(fontSize: 44, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                              ),
                              Text('اجمالي مبيعات الفلير')
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: _width/4,
                        height: _height/4.2,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1,350,114 SDG',
                                style: TextStyle(fontSize: 40, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                              ),
                              Text('ارباح الشهر بالسوداني')
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: _width/4,
                        height: _height/4.2,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '2,540 AED',
                                style: TextStyle(fontSize: 40, color: Colors.lightGreen, fontWeight: FontWeight.bold),
                              ),
                              Text('ارباح الشهر بالدرهم')
                            ],
                          ),
                        ),
                      ),
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
