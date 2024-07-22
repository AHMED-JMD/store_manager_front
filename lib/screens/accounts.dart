import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/components/AccountsTable.dart';
import 'package:store_manager/components/Header.dart';
import 'package:store_manager/components/SideBar.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final SidebarXController controller = SidebarXController(selectedIndex: 2,);

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
                    myHeader('العملاء والمنصرفات',),
                    SizedBox(height: 70,),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: AccountsTable(),
                    ),
                  ],
                )
              )
            ],
          )
      ),
    );
  }
}
