import 'package:read_data/providers/mhs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/mhs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MhsProvider(),
        )
      ],
      child: MaterialApp(
        home: Mhs(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}