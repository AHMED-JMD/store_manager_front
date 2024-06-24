import 'package:flutter/material.dart';

class DeleteModal extends StatelessWidget {
  final String title;
  final String id;
  final Function(String) deleteFunc;

  DeleteModal({
    super.key,
    required this.title,
    required this.id,
    required this.deleteFunc,
  });


  //modal open
  deleteModal (BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('حذف $title', textAlign: TextAlign.center,),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text('هل انت متأكد برغبتك في حذف $title', style: TextStyle(
                      fontSize: 19, color: Colors.redAccent, fontWeight: FontWeight.w900
                  ),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                    onPressed: (){
                      //call delete func
                      deleteFunc(id);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: Size(100, 40),
                    ),
                    child: Text('حذف', style: TextStyle(color: Colors.white, fontSize: 17),)
                ),
              ),
            ]
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        deleteModal(context);
      },
      icon: Icon(Icons.delete, color: Colors.redAccent,),
    );
  }
}
