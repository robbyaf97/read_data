import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './mhs_add.dart';
import './mhs_edit.dart';
import '../models/mhs_model.dart';
import '../providers/mhs_provider.dart';

class Mhs extends StatelessWidget {
  final data = [
    MhsModel(
      mhsNim: "111111111",
      mhsNama: "Test",
      mhsKelas: "SI7K",
      mhsKdMatkul: "001",
      mhsEmail: "test@gmail.com",
    ),
    MhsModel(
      mhsNim: "222222",
      mhsNama: "Test2",
      mhsKelas: "SI7K",
      mhsKdMatkul: "001",
      mhsEmail: "test2@gmail.com",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data MHS'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Text('+'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MhsAdd()));
        },
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<MhsProvider>(context, listen: false).getMhs(),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<MhsProvider>(context, listen: false)
                .getMhs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<MhsProvider>(
                builder: (context, data, _) {
                  return ListView.builder(
                    itemCount: data.dataMhs.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MhsEdit(
                                id: data.dataMhs[i].id,
                              ),
                            ),
                          );
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) async {
                            final bool res = await showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi'),
                                content: Text('Kamu Yakin?'),
                                actions: <Widget>[
                                  FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Text('HAPUS'),),
                                  FlatButton(onPressed: () => Navigator.of(context).pop(false), child: Text('BATALKAN'),)
                                ],
                              );
                            });
                            return res;
                          },
                          onDismissed: (value) {
                            Provider.of<MhsProvider>(context, listen: false).deleteMhs(data.dataMhs[i].nim);
                          },
                          child: Card(
                            elevation: 8,
                            child: ListTile(
                              title: Text(
                                data.dataMhs[i].mhsNim,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  'Nama: ${data.dataMhs[i].mhsNama}'),
                              subtitle: Text(
                                  'Kelas: ${data.dataMhs[i].mhsKelas}'),
                              subtitle: Text(
                                  'Kode Matkul: ${data.dataMhs[i].mhsKdmatkul}'),
                              trailing: Text(
                                  "\$${data.dataMhs[i].mhsEmail}"),
                              
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}