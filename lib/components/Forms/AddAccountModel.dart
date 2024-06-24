import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/API/account_api.dart';

class AddAccount extends StatefulWidget {
  final Function(bool) refresh;
  const AddAccount({super.key, required this.refresh});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final accountController = TextEditingController(text: '0');

  @override
  void dispose () {
    nameController.dispose();
    phoneController.dispose();
    accountController.dispose();
    super.dispose();
  }

  //server function
  Future AddAccount(data) async {
    widget.refresh(true);
    //call api
    final response = await AccountApi.add(data);
    Navigator.pop(context);
    widget.refresh(false);

    if(response is DioException){
      DioException err = response;

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
              child: Text('${err.response!.data['message']}', style: const TextStyle(
                fontSize: 20,
                color: Colors.white
                ),
              ),
            ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 2),
        )
      );
    }else{
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text('تمت الاضافة بنجاح', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
              ),
            ),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 800),
          )
      );
    }
  }

  //modal
  addModal(BuildContext context) {
    return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SimpleDialog(
              title: const Text('حساب جديد', textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
              elevation: 5,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'اسم العميل',
                              icon: Icon(Icons.person_pin, color: Colors.green,),
                              contentPadding: EdgeInsets.only(top: 2)
                            ),
                            keyboardType: TextInputType.text,
                            validator: (val){
                              if(val!.isEmpty) return 'الرجاء ادخال الاسم';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'رقم الهاتف',
                              icon: Icon(Icons.phone_android, color: Colors.green,),
                              contentPadding: EdgeInsets.only(top: 2)
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(val!.isEmpty) return 'الرجاء ادخال رقم الهاتف';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 300,
                          child: TextFormField(
                            controller: accountController,
                            decoration: InputDecoration(
                              labelText: 'الحساب',
                              icon: Icon(Icons.monetization_on, color: Colors.green,),
                              contentPadding: EdgeInsets.only(top: 2)
                            ),
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if(val!.isEmpty) return 'الرجاء ادخال الحساب';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 50,),

                        ElevatedButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                Map data = {};
                                data['name'] = nameController.text;
                                data['phone_num'] = phoneController.text;
                                data['account'] = accountController.text;

                                //call api
                                AddAccount(data);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(2, 48, 71, 1),
                              minimumSize: Size(150, 45)
                            ),
                            child: Text('اضافة', style: TextStyle(color: Colors.white, fontSize: 17),)
                        )
                      ],
                    )
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: (){
        addModal(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightGreen[700],
      ),
      icon: Icon(Icons.add, color: Colors.white,),
      label: Text('حساب جديد', style: TextStyle(color: Colors.white),),
    );
  }
}
