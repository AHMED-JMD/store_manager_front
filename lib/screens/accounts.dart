import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/components/AccountsTable.dart';
import 'package:store_manager/components/Expenses.dart';
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
                    SizedBox(height: 20,),
                    Text('العملاء والمنصرفات',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 23),
                    ),
                    Divider(color: Colors.green, indent: 150, endIndent: 150, thickness: 2,),
                    SizedBox(height: 70,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 700,
                          width: 620,
                          child: AccountsTable(),
                        ),
                        Expenses(),
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
