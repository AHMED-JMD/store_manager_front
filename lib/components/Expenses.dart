import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List numbers = [120, 240, 250];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('المنصرفات', style: TextStyle(fontSize: 22),),
            const SizedBox(width: 20,),
            ElevatedButton(onPressed: (){}, child: const Text('اضافة منصرف'))
          ],
        ),
        const SizedBox(height: 20,),
        Container(
          height: 700,
          width: 450,
          child: ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 6,
                    child: ListTile(
                      title: Text(numbers[index].toString()),
                    )
                );
              }
          ),
        ),
      ],
    );
  }
}
