import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/API/account_api.dart';
import 'package:store_manager/components/Forms/AddAccountModel.dart';
import 'package:store_manager/components/Forms/UpdateAccount.dart';
import 'package:store_manager/components/Forms/deleteModal.dart';
import 'package:store_manager/models/account.dart';

class AccountsTable extends StatefulWidget {
  const AccountsTable({super.key});

  @override
  State<AccountsTable> createState() => _AccountsTableState();
}

class _AccountsTableState extends State<AccountsTable> {
   int rowsPerPage = 5;
   late final source = AccountSource(deleteAccount: deleteAccount, refresh: refresh);
   bool isRefresh = false;

   //server func
   Future deleteAccount (String id) async {
     refresh(true);
     //call
     final response = await AccountApi.delete(id);

     if(response.statusCode == 200){
       Navigator.pop(context);
       refresh(false);

       return ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Center(
               child: Text('تم حذف الحساب بنجاح', style: TextStyle(
                   fontSize: 20,
                   color: Colors.white
               ),
               ),
             ),
             backgroundColor: Colors.redAccent,
             duration: Duration(seconds: 2),
           )
       );
     }
   }

   //setState of table every time server called
   void refresh (bool IsRefresh) {
     setState(() {
       isRefresh = IsRefresh;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AddAccount(refresh: refresh,),
          ],
        ),
        const SizedBox(height: 10,),
        isRefresh != true ?
        AdvancedPaginatedDataTable(
            source: source,
            showFirstLastButtons: true,
            showCheckboxColumn: true,
            addEmptyRows: false,
            rowsPerPage: rowsPerPage,
            availableRowsPerPage: const [5, 10, 25],
            onRowsPerPageChanged: (newRowsPerPage) {
              if(newRowsPerPage != null){
                setState(() {
                  rowsPerPage = newRowsPerPage;
                });
              }
            },
            columns: const [
              DataColumn(label: Text('الاسم')),
              DataColumn(label: Text('رقم التلفون')),
              DataColumn(label: Text('الحساب')),
              DataColumn(label: Text('')),
            ],
        ): const CircularProgressIndicator(),
      ],
    );
  }
}

class AccountSource extends AdvancedDataTableSource<Account>{
  final Function(String) deleteAccount;
  final Function(bool) refresh;
  AccountSource({required this.deleteAccount, required this.refresh});

  @override
  DataRow? getRow (int index) {
    final currentRowData = lastDetails!.rows[index];
    return DataRow(
        cells: [
          DataCell(Text(currentRowData.name)),
          DataCell(Text(currentRowData.phoneNum)),
          DataCell(Text(currentRowData.account.toString(), style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)),
          DataCell(Row(
            children: [
              UpdateAccount(title: currentRowData.name, id: currentRowData.id, refresh: refresh,),
              DeleteModal(title: ' حساب ${currentRowData.name}', id: currentRowData.id, deleteFunc: deleteAccount)
          ],))
        ]
    );
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Account>> getNextPage (NextPageRequest pageRequest) async {
    //get data from db
    final response = await AccountApi.getAll();
    List newdata = response.data;

    return RemoteDataSourceDetails(
        newdata.length,
        newdata.map((datas) => Account.fromJson(datas))
            .skip(pageRequest.offset)
            .take(pageRequest.pageSize)
            .toList()
    );
  }
}
