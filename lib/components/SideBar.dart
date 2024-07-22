import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class MySideBar extends StatelessWidget {
  final SidebarXController controller;
  const MySideBar({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(2, 48, 71, 1),
          borderRadius: BorderRadius.circular(8)
        ),
        textStyle: TextStyle(fontSize: 16, color: Colors.white),
        selectedTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        hoverTextStyle: TextStyle(fontSize: 16),
        itemTextPadding: EdgeInsets.only(right: 10),
        selectedItemTextPadding: EdgeInsets.only(right: 20),
        iconTheme: IconThemeData(size: 30, color: Colors.green),
        selectedIconTheme: IconThemeData(size: 40, color: Colors.white),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green)
        ),
        selectedItemDecoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.lightGreen)
        )
      ),
      animationDuration: Duration(milliseconds: 200) ,
      extendedTheme: SidebarXTheme(
        width: 200
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
        );
      },
      footerDivider: Divider(thickness: 2, color: Colors.green,),
      items: [
        SidebarXItem(
            icon: Icons.home_work,
            label: "الرئيسية",
            onTap: (){
              Navigator.pushReplacementNamed(context, '/');
            }
        ),
        SidebarXItem(
            icon: Icons.assignment,
            label: "المعاملات",
            onTap: (){
              Navigator.pushReplacementNamed(context, '/store');
            }
        ),
        SidebarXItem(
            icon: Icons.account_box,
            label: "الحسابات",
            onTap: (){
              Navigator.pushReplacementNamed(context, '/accounts');
            }
        ),
        SidebarXItem(
            icon: Icons.store,
            label: "المخزن",
            onTap: (){
              Navigator.pushReplacementNamed(context, '/settings');
            }
        ),
      ],
    );
  }
}
