import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/components/Header.dart';
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
                child: ListView(
                  children: [
                      myHeader('المعاملات'),
                      SizedBox(height: 20,),

                      TransTable(),
                    ],
                )
              )
            ],
          )
      ),
    );
  }
}
