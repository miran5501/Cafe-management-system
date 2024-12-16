import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:flutter/material.dart';
import 'package:cafe_proje/sayfalar/sabit_alan.dart';
import 'package:cafe_proje/sayfalar/masalar.dart';
import 'package:flutter/services.dart';
import 'package:cafe_proje/sayfalar/giris_Sayfasi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: "Kafe Yönetim Sistemi",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "fonts"),
        home: Giris(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedId = ''; // Seçilen ID'yi tutacak değişken

  void handleSelection(String id) {
    setState(() {
      selectedId = id; // Seçilen alanın ID'sini alıyoruz
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SabitAlanBar(
            onSelected: handleSelection, // Seçilen ID'yi burada işliyoruz
          ),
          Expanded(
            child: Masalar(
              selectedId: selectedId,
            ),
          ),
        ],
      ),
    );
  }
}
