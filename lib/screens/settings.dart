import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/components/Forms/AddStoreModel.dart';
import 'package:store_manager/components/Forms/deleteModal.dart';
import 'package:store_manager/components/Forms/UpdateStoreModel.dart';
import 'package:store_manager/components/Header.dart';
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
                            suffixIcon: Icon(Icons.search_outlined)
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    data.length != 0 ?
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                      height: 800,
                      child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index){
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ListView(
                                children: [
                                  Image.asset(
                                    'assets/images/storeImage.jpg',
                                    height: 100,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  // Add a container with padding that contains the card's title, text, and buttons
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${data[index].name}",
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                            Text(
                                              "${data[index].sellPrice} جنيه ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Add a space between the title and the text
                                        SizedBox(height: 10),
                                        Column(
                                          children: [
                                            Container(
                                              width: 250,
                                              child: Text(
                                                " سعر الشراء ${data[index].price}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              width: 250,
                                              child: Text(
                                                " موقع الصنف ${data[index].location}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                              UpdateStore(GetItems: GetItems, title: data[index].name, id: data[index].id,),
                                              DeleteModal(title: data[index].name, id: data[index].id, deleteFunc: DeleteItems,),
                                            ],
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      )
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
