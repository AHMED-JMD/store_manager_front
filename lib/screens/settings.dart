import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/components/Forms/AddStoreModel.dart';
import 'package:store_manager/components/Forms/deleteModal.dart';
import 'package:store_manager/components/Forms/UpdateStoreModel.dart';
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
                    Text(
                        'ادارة المخازن',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                    ),
                    Divider(
                      indent: 180,
                      endIndent: 180,
                      thickness: 2,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: AddStore(GetItems: GetItems,)
                        )
                      ],
                    ),
                    data.length != 0 ?
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                      height: 700,
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index ){
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ListTile(
                                    leading: Icon(Icons.store),
                                    title: Text(data[index].name, style: TextStyle(fontSize: 19),),
                                    subtitle: Text(' سعر البيع: ${data[index].sellPrice}'),
                                    trailing: Container(
                                      width: 300,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          UpdateStore(GetItems: GetItems, title: data[index].name, id: data[index].id),
                                          SizedBox(width: 7,),
                                          DeleteModal(title: data[index].name, id: data[index].id, deleteFunc: DeleteItems)
                                        ]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ) : Center(child: CircularProgressIndicator(),) ,
                  ]
                )
              )
            ],
          )
      ),
    );
  }
}
