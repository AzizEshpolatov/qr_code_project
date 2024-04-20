import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_project/bloc/products_bloc.dart';
import 'package:qr_code_project/bloc/products_event.dart';
import 'package:qr_code_project/screens/tab_box_screen/tab_box_screen.dart';
import 'package:qr_code_project/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()..add(LoadProducts())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const TabBox(),
    );
  }
}
