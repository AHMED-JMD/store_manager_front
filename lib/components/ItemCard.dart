import 'package:flutter/material.dart';
import 'package:store_manager/components/Forms/UpdateStoreModel.dart';
import 'package:store_manager/components/Forms/deleteModal.dart';
import 'package:store_manager/models/stores.dart';

class ItemCard extends StatelessWidget {
  final Store data;
  final Function GetItems;
  final Function(String) DeleteItems;

  const ItemCard({
    super.key,
    required this.data,
    required this.GetItems,
    required this.DeleteItems
  });

  @override
  Widget build(BuildContext context) {
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
                      "${data.name}",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      "${data.sellPrice} جنيه ",
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
                        " سعر الشراء ${data.price}",
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
                        " موقع الصنف ${data.location}",
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
                    UpdateStore(GetItems: GetItems, title: data.name, id: data.id,),
                    DeleteModal(title: data.name, id: data.id, deleteFunc: DeleteItems,),
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
}
