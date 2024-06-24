import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/API/account_api.dart';

class UpdateAccount extends StatefulWidget {
  final String title;
  final String id;
  final Function(bool) refresh;

  const UpdateAccount({
    super.key,
    required this.title,
    required this.id,
    required this.refresh,
  });

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final accountController = TextEditingController();

  @override
  void dispose () {
    nameController.dispose();
    phoneController.dispose();
    accountController.dispose();
    super.dispose();
  }

  //server func
  Future UpdateAccount(data) async {
    widget.refresh(true);

    //call api
    final response = await AccountApi.update(widget.id, data);
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
              child: Text('تمت التعديل بنجاح', style: TextStyle(
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
  Future getById() async {
    //call api
    final response = await AccountApi.getById(widget.id);

    if(response.statusCode == 200){
      Map data = response.data;

      setState(() {
        nameController.text = data['name'];
        phoneController.text = data['phoneNum'];
        accountController.text = data['account'].toString();
      });
    }

  }

  //update modal
  updateModal(BuildContext context) {
    getById();
    return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SimpleDialog(
                title: Text(' تعديل ${widget.title}', textAlign: TextAlign.center,),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
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
                        SizedBox(height: 70,),

                        ElevatedButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                Map data = {};
                                data['name'] = nameController.text;
                                data['phone_num'] = phoneController.text;
                                data['account'] = accountController.text;

                                //call api
                               await UpdateAccount(data);
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(2, 48, 71, 1),
                                minimumSize: Size(150, 45)
                            ),
                            child: Text('تعديل', style: TextStyle(color: Colors.white, fontSize: 17),)
                        )
                      ],
                    ),
                  )
                ],
              )
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          updateModal(context);
        },
        icon: Icon(Icons.edit_note, color: Colors.lightGreen[900]),
        tooltip: 'تعديل'
    );
  }
}
