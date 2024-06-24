import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/components/SideBar.dart';
import 'package:store_manager/components/TransTable.dart';

class MyStore extends StatefulWidget {
  const MyStore({super.key});

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  final SidebarXController controller = SidebarXController(selectedIndex: 1,);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Row(
            children: [
              MySideBar(controller: controller),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ElevatedButton(
                                onPressed: (){},
                                child: Text('اضافة معاملة')
                            ),
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: TransTable()
                      ),
                    ],
                  ),
                )
              )
            ],
          )
      ),
    );
  }
}
