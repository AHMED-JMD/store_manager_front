import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/components/Forms/AddStoreModel.dart';
import 'package:store_manager/components/Header.dart';
import 'package:store_manager/components/ItemCard.dart';
import 'package:store_manager/components/SideBar.dart';
import 'package:store_manager/models/stores.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final SidebarXController controller = SidebarXController(selectedIndex: 3,);
  List<Store> data = [];
  List<Store> filtered_data = [];
  bool isLoading = false;

  @override
  void initState() {
    GetItems();
    super.initState();
  }

  //server func
  Future GetItems () async {
    setState(() {
      isLoading = true;
      data = [];
    });

    //call db
    final response = await StoreApi.getItems();
    setState(() {
      isLoading = false;
    });

    if(response.statusCode == 200){
      //map throw data and add to store
      response.data.forEach((item) => {
        setState(() {
          data.add(Store.fromJson(item));
        })
      });
      setState(() {
        filtered_data = data;
      });
    }
  }

  Future DeleteItems (String id) async {
    setState(() {
      isLoading = true;
    });

    //call db
    final response = await StoreApi.deleteItems(id);
    Navigator.pop(context);
    setState(() {
      isLoading = false;
    });

    if(response.statusCode == 200){
      //call get item again
      GetItems();
    }
  }

  //function for instant search
  void SearchItems(String query){
    if(query == ''){
      setState(() {
        filtered_data = data;
      });
    }else{
      setState(() {
        filtered_data = data.where((element) => element.name.contains(query.toLowerCase())).toList();
      });
    }

  }

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
                    myHeader('ادارة المخازن',),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: AddStore(GetItems: GetItems,)
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Center(
                      child: Container(
                        width: 400,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'ابحث عن صنف',
                            icon: Icon(Icons.search_outlined),
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  filtered_data = data;
                                });
                              },
                              icon: Icon(Icons.all_inbox_rounded, size: 30,),
                              tooltip: 'كل الاصناف',
                            )
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            SearchItems(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    filtered_data.length != 0 ?
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                      height: 800,
                      child: GridView.builder(
                          itemCount: filtered_data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index){
                            return ItemCard(data: filtered_data[index], GetItems: GetItems, DeleteItems: DeleteItems,);
                          }
                      )
                    ) : Center(
                      child: Container(
                        width: 300,
                        height: 70,
                        color: Colors.grey[200],
                        child: Center(child: Text('لاتوجد اصناف', style: TextStyle(fontSize: 19),)),
                      ),
                    ),
                  ]
                )
              )
            ],
          )
      ),
    );
  }
}
