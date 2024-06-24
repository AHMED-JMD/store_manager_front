import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/models/transactions.dart';

class TransTable extends StatefulWidget {
  const TransTable({super.key});

  @override
  State<TransTable> createState() => _TransTableState();
}

class _TransTableState extends State<TransTable> {
  var rowsPerPage = 10;
  final source = TransSource();

  @override
  Widget build(BuildContext context) {
    return AdvancedPaginatedDataTable(
      source: source,
      showHorizontalScrollbarAlways: true,
      addEmptyRows: false,
      rowsPerPage: rowsPerPage,
      showFirstLastButtons: true,
      availableRowsPerPage: [5, 10, 30],
      onRowsPerPageChanged: (newRowsPerPage){
        if(newRowsPerPage != null){
          setState(() {
            rowsPerPage = newRowsPerPage;
          });
        }
      },
      columns: [
        DataColumn(label: Text('التاريخ')),
        DataColumn(label: Text('النوع')),
        DataColumn(label: Text('الصنف')),
        DataColumn(label: Text('الكمية')),
        DataColumn(label: Text('السعر')),
        DataColumn(label: Text('المندوب')),
        DataColumn(label: Text('')),
      ],
    );
  }
}

class TransSource extends AdvancedDataTableSource<Transaction>{
  final data = List<Transaction>.generate(
      9, (index) => Transaction(type: 'بيع', item: "فلير", amount: index, price: 750, date: '15-06-2024', account: 'محمد الفاضل')
  );

  @override
  DataRow? getRow (int index){
    final currentRowData = lastDetails!.rows[index];
    
    return DataRow(
        cells: [
          DataCell(Text(currentRowData.date)),
          DataCell(Text(currentRowData.type)),
          DataCell(Text(currentRowData.item)),
          DataCell(Text(currentRowData.amount.toString())),
          DataCell(Text(currentRowData.price.toString())),
          DataCell(Text(currentRowData.account)),
          DataCell(IconButton(
            onPressed: (){},
            icon: Icon(Icons.delete, color: Colors.redAccent,),
          ))
        ]
    );
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Transaction>> getNextPage(NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
        data.length,
        data
            .skip(pageRequest.offset)
            .take(pageRequest.pageSize)
            .toList()
    );
  }
}
