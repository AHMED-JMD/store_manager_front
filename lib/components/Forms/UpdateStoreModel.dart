import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/models/stores.dart';

class UpdateStore extends StatefulWidget {
  final Function GetItems;
  final String title;
  final String id;

  const UpdateStore({
    super.key,
    required this.GetItems,
    required this.title,
    required this.id,
  });

  @override
  State<UpdateStore> createState() => _UpdateStoreState();
}

class _UpdateStoreState extends State<UpdateStore> {
  //form key & controllers
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final sellPriceController = TextEditingController();
  final locationController = TextEditingController(text: 'مصر');

  bool isLoading = false;
  Store? item;


  @override
  void dispose (){
    //clean up controllers
    nameController.dispose();
    priceController.dispose();
    sellPriceController.dispose();
    locationController.dispose();

    super.dispose();
  }

  //server func
  Future getById () async {
    setState(() {
      isLoading = true;
    });

    //call api
    final response = await StoreApi.getItemsById(widget.id);
    if(response.statusCode == 200){
      item = Store.fromJson(response.data);

      setState(() {
        nameController.text = item!.name;
        priceController.text = item!.price.toString();
        sellPriceController.text = item!.sellPrice.toString();
        locationController.text = item!.location;
      });
    }
  }

  Future UpdateItem (data) async {
    setState(() {
      isLoading = true;
    });

    //call api
    final response = await StoreApi.updateItems(widget.id, data);
    //refresh setting page
    widget.GetItems();

    if(response is DioException){
      Navigator.pop(context);

      DioException err = response;
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text('${err.response!.data['message']}', style: TextStyle(fontSize: 21, color: Colors.white),),
            ),
            backgroundColor: Colors.redAccent,
            elevation: 8,
            duration: Duration(seconds: 4),
            showCloseIcon: true,
            closeIconColor: Colors.redAccent,
          )
      );
    }
    else {
      if(response.statusCode == 200){
        //pop out
        Navigator.pop(context);

        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text('تم التعديل بنجاح', style: TextStyle(fontSize: 21, color: Colors.white),),
              ),
              backgroundColor: Colors.green,
              elevation: 8,
              duration: Duration(milliseconds: 800),
              showCloseIcon: true,
              closeIconColor: Colors.redAccent,
            )
        );

      }
    }
  }


  //model class
  updateModal (BuildContext context) async {
    //call get data by id only when opening model not entire page
    getById();

    return showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context, setState) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    icon: Icon(Icons.update),
                    title: Text('تعديل صنف ${widget.title}'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'الاسم',
                              contentPadding: EdgeInsets.only(top: 3),
                              prefixIcon: Icon(Icons.person_pin, color: Colors.lightGreen,),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) return 'الرجاء ادخال الاسم';
                              return null;
                            },
                          ),
                          SizedBox(height: 12,),
                          TextFormField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: 'السعر',
                              contentPadding: EdgeInsets.only(top: 3),
                              prefixIcon: Icon(Icons.price_change, color: Colors.lightGreen,),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value){
                              if (value!.isEmpty) return 'الرجاء ادخال السعر';
                              return null;
                            },
                          ),
                          SizedBox(height: 12,),
                          TextFormField(
                            controller: sellPriceController,
                            decoration: InputDecoration(
                                labelText: 'سعر البيع',
                                contentPadding: EdgeInsets.only(top: 3),
                                prefixIcon: Icon(Icons.price_check, color: Colors.lightGreen,)
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) return 'الرجاء ادخال سعر البيع';
                              return null;
                            },
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                              labelText: 'الموقع',
                              prefixIcon: Icon(Icons.location_on, color: Colors.lightGreen,),
                              contentPadding: EdgeInsets.only(top: 3),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value){
                              if(value!.isEmpty) return 'الرجاء ادخال الموقع';
                              return null;
                            },
                          ),
                          SizedBox(height: 30,),
                          ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  Map data = {};
                                  data['name'] = nameController.text;
                                  data['price'] = priceController.text;
                                  data['sell_price'] = sellPriceController.text;
                                  data['location'] = locationController.text;

                                  //call form api
                                  UpdateItem(data);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(2, 48, 71, 1),
                                  minimumSize: Size(200, 50)
                              ),
                              child: Text('تعديل', style: TextStyle(color: Colors.lightGreen, fontSize: 17),)
                          )
                        ],
                      ),
                    ),
                    actions: [
                      ButtonBar(
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              tooltip: 'اغلاق',
                              icon: Icon(Icons.cancel_rounded, color: Colors.redAccent,)
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }

          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: (){
          updateModal(context);
        },
        icon: Icon(Icons.more_horiz, color: Colors.lightGreen[900]),
        label: Text('التفاصيل', style: TextStyle(color: Colors.lightGreen[900]),)
    );
  }
}
