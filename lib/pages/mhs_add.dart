import 'package:read_data/pages/mhs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mhs_provider.dart';

class MhsAdd extends StatefulWidget {
  @override
  _MhsAddState createState() => _MhsAddState();
}

class _MhsAddState extends State<MhsAdd> {
  final TextEditingController _nim = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _kelas = TextEditingController();
  final TextEditingController _kdmatkul = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool _isLoading = false;

  final snackbarKey = GlobalKey<ScaffoldState>();

  FocusNode namaNode = FocusNode();
  FocusNode kelasNode = FocusNode();
  FocusNode kdmatkulNode = FocusNode();
  FocusNode emailNode = FocusNode();

  void submit(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MhsProvider>(context, listen: false)
          .storeMhs(_nim.text, _nama.text, _kelas.text, _kdmatkul.text, _email.text)
          .then((res) {
        if (res) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Mhs()), (route) => false);
        } else {
          var snackbar = SnackBar(content: Text('Ops, Error. Hubungi Admin'),);
          snackbarKey.currentState.showSnackBar(snackbar);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text('Add Mhs'),
        actions: <Widget>[
          FlatButton(
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
            onPressed: () => submit(context),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _nim,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Nim',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(namaNode);
              },
            ),
            TextField(
              controller: _nama,
              focusNode: namaNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Nama',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(kelasNode);
              },
            ),
            TextField(
              controller: _kelas,
              focusNode: kelasNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Kelas',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(kdmatkulNode);
              },
            ),
            TextField(
              controller: _kdmatkul,
              focusNode: kdmatkulNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Kode Matkul',
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(emailNode);
              },
            ),
            TextField(
              controller: _email,
              focusNode: emailNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}