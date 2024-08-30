import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/API/account_api.dart';
import 'package:store_manager/API/store_api.dart';
import 'package:store_manager/API/trans_api.dart';
import 'package:store_manager/components/Formatters.dart';
import 'package:store_manager/components/Forms/deleteModal.dart';
import 'package:store_manager/components/MyCard.dart';
import 'package:store_manager/models/transactions.dart';

class TransTable extends StatefulWidget {
  const TransTable({super.key});

  @override
  State<TransTable> createState() => _TransTableState();
}

class _TransTableState extends State<TransTable> {
  var rowsPerPage = 10;
  late var source = TransSource(
    data: data,
    context: context,
    deleteTran: deleteTran,
    refresh: refresh,
  );

  List data = [];
  List emps = [];
  List items = [];
  bool isRefresh = false;
  double totalIncome = 0;
  double totalOutcome = 0;

  String? item_id;
  String? emp_id;
  final dateControllerFrom = TextEditingController();
  final dateControllerTo = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getTrans();
    _getEmps();
    _getItems();
    super.initState();
  }

  //server function
  Future _getTrans() async {
    refresh(true);
    String today_date =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

    final response = await TranApi.getAll(today_date);
    refresh(false);

    if (response is DioException) {
      setState(() {
        data = [];
      });
    } else {
      setState(() {
        data = response.data['trans'];
        totalIncome = response.data['totals']['totalIncome'].toDouble();
        totalOutcome = response.data['totals']['totalOutcome'].toDouble();
      });
    }
  }

  Future _getEmps() async {
    final response = await AccountApi.getAll();

    setState(() {
      emps = response.data;
    });
  }

  Future _getItems() async {
    final response = await StoreApi.getItems();

    setState(() {
      items = response.data;
    });
  }

  Future _filterTrans(datas) async {
    setState(() {
      data = [];
    });
    final response = await TranApi.filter(datas);

    if (response is DioException) {
      setState(() {
        data = [];
      });
    } else {
      setState(() {
        data = response.data['trans'];
        totalIncome = response.data['totals']['totalIncome'].toDouble();
        totalOutcome = response.data['totals']['totalOutcome'].toDouble();
        source = TransSource(
          data: data,
          context: context,
          deleteTran: deleteTran,
          refresh: refresh,
        );
      });
    }
  }

  Future deleteTran(String id) async {
    refresh(true);

    final response = await TranApi.deleteTran(id);

    if (response.statusCode == 200) {
      refresh(false);
      _getTrans();
      Navigator.pop(context);
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
          child: Text(
            'تم حذف المعاملة بنجاح',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ));
    }
  }

  //void function to refresh and pass it to table
  void refresh(bool isrefresh) {
    setState(() {
      isRefresh = isrefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyCard(
              width_num: 3.1,
              height_num: 4.3,
              title: totalIncome,
              subtitle: "اجمالي العوائد",
              Icon: Icon(
                Icons.arrow_upward,
                color: Colors.green,
                size: 45,
              ),
            ),
            MyCard(
              width_num: 3.1,
              height_num: 4.3,
              title: totalOutcome,
              subtitle: "اجمالي المنصرفات",
              Icon: Icon(
                Icons.arrow_downward,
                color: Colors.red,
                size: 45,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Divider(
          endIndent: 250,
          indent: 250,
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  children: [
                    Text(
                      'من :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: dateControllerFrom,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'اختر اليوم',
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.green,
                            )),
                        onTap: () async {
                          DateTime? selected_date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));

                          if (selected_date != null) {
                            String date =
                                '${selected_date.year}-${selected_date.month}-${selected_date.day}';

                            setState(() {
                              dateControllerFrom.text = date;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'الى :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: dateControllerTo,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'اختر اليوم',
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.green,
                            )),
                        onTap: () async {
                          DateTime? selected_date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));

                          if (selected_date != null) {
                            String date =
                                '${selected_date.year}-${selected_date.month}-${selected_date.day}';

                            setState(() {
                              dateControllerTo.text = date;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 180,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'اختر صنف',
                            icon: Icon(Icons.list, color: Colors.green)),
                        items: items
                            .map((item) => DropdownMenuItem(
                                  child: Text('${item['name']}'),
                                  value: item['id'],
                                ))
                            .toList(),
                        onChanged: (val) {
                          item_id = val.toString();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 190,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'اختر عميل',
                            icon:
                                Icon(Icons.person_search, color: Colors.green)),
                        items: emps
                            .map((emp) => DropdownMenuItem(
                                  child: Text('${emp['name']}'),
                                  value: emp['id'],
                                ))
                            .toList(),
                        onChanged: (val) {
                          emp_id = val.toString();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Map data = {};
                          data['start_date'] = dateControllerFrom.text;
                          data['end_date'] = dateControllerTo.text;
                          data['item_id'] = item_id;
                          data['emp_id'] = emp_id;

                          //call server
                          _filterTrans(data);

                          //reset form data
                          _formKey.currentState!.reset();
                          setState(() {
                            dateControllerTo.text = '';
                            dateControllerFrom.text = '';
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            minimumSize: Size(80, 50)),
                        child: Text('فلترة'))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, left: 25),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/add-tran');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    label: Text(
                      'اضافة معاملة',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        isRefresh != true && data.length != 0
            ? Container(
                padding: EdgeInsets.all(20),
                child: AdvancedPaginatedDataTable(
                  source: source,
                  showHorizontalScrollbarAlways: true,
                  addEmptyRows: false,
                  rowsPerPage: rowsPerPage,
                  showFirstLastButtons: true,
                  availableRowsPerPage: [5, 10, 30],
                  onRowsPerPageChanged: (newRowsPerPage) {
                    if (newRowsPerPage != null) {
                      setState(() {
                        rowsPerPage = newRowsPerPage;
                      });
                    }
                  },
                  columns: [
                    DataColumn(label: SizedBox()),
                    DataColumn(
                        label: Text(
                      'التاريخ',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(
                        label: Text(
                      'النوع',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(
                        label: Text(
                      'الصنف',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(
                        label: Text(
                      'الكمية',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(
                        label: Text(
                      'السعر',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(
                        label: Text(
                      'الاجمالي',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(
                        label: Text(
                      'المندوب',
                      style: TextStyle(fontSize: 18),
                    )),
                    DataColumn(label: SizedBox()),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ],
    );
  }
}

class TransSource extends AdvancedDataTableSource<Transaction> {
  final List data;
  final BuildContext context;
  final Function(String) deleteTran;
  final Function(bool) refresh;

  TransSource({
    required this.data,
    required this.context,
    required this.deleteTran,
    required this.refresh,
  });

  @override
  DataRow? getRow(int index) {
    final currentRowData = lastDetails!.rows[index];
    DateTime date = DateTime.parse(currentRowData.date);

    return DataRow(cells: [
      DataCell(
        currentRowData.type == 'بيع'
            ? Icon(
                Icons.arrow_circle_up,
                color: Colors.green,
                size: 25,
              )
            : Icon(
                Icons.arrow_circle_down,
                color: Colors.red,
                size: 25,
              ),
      ),
      DataCell(Text(
        "${date.year}-${date.month}-${date.day}",
        style: TextStyle(fontSize: 17),
      )),
      DataCell(Text(
        currentRowData.type,
        style: TextStyle(fontSize: 17),
      )),
      DataCell(Text(
        currentRowData.itemName,
        style: TextStyle(fontSize: 17),
      )),
      DataCell(Text(
        moneyFormatter(currentRowData.amount),
        style: TextStyle(fontSize: 17),
      )),
      DataCell(Text(
        moneyFormatter(currentRowData.price),
        style: TextStyle(fontSize: 17),
      )),
      DataCell(Text(
        "${moneyFormatter(currentRowData.price * currentRowData.amount)}",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      )),
      DataCell(Text(
        currentRowData.empName,
        style: TextStyle(fontSize: 17),
      )),
      DataCell(Row(
        children: [
          SizedBox(
            width: 10,
          ),
          DeleteModal(
              title: "المعاملة", id: currentRowData.id, deleteFunc: deleteTran),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        'تعليق المعاملة',
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                              child: Text(
                            currentRowData.comment != null
                                ? currentRowData.comment!
                                : "لايوجد تعليق",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 10),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                              ),
                              child: Text(
                                'اغلاق',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )),
                        )
                      ],
                      elevation: 3,
                    );
                  });
            },
            icon: Icon(
              Icons.comment,
              color: Colors.blueGrey,
            ),
            tooltip: 'تعليق المعاملة',
          ),
        ],
      ))
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Transaction>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
        data.length,
        data
            .map((json) => Transaction.fromJson(json))
            .skip(pageRequest.offset)
            .take(pageRequest.pageSize)
            .toList());
  }
}
