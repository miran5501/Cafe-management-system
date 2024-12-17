import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/sayfalar/main.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:cafe_proje/models/global.dart';

class Islemler extends StatefulWidget {
  final String masaId;
  final bool masaDurumu;
  final Function(MasaModel) updateMasaCallback;
  const Islemler(
      {super.key,
      required this.masaId,
      required this.masaDurumu,
      required this.updateMasaCallback});

  @override
  State<Islemler> createState() => _IslemlerState();
}

class _IslemlerState extends State<Islemler> {
  late bool masadurum; // Değişken tanımı

  @override
  void initState() {
    super.initState();
    masadurum = widget.masaDurumu; // Değerin atanması
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Color(0XFFEEEEEE),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                      },
                      splashColor:
                          Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
                      highlightColor:
                          Colors.pink.withOpacity(0.10), // Tıklama vurgusu
                      borderRadius: BorderRadius.circular(10),
                      child: const Column(
                        mainAxisSize: MainAxisSize
                            .min, // Bu, Column'un minimum alanda yer kaplamasını sağlar
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.pinkAccent,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Geri',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Divider(),
                    InkWell(
                      onTap: () async {
                        try {
                          if (masadurum == true) {
                            MasaModel updatedMasa = await apiService.kapatMasa(
                                token: globalToken!, masaId: widget.masaId);
                            widget.updateMasaCallback(updatedMasa);
                            masadurum = false;
                          } else {
                            MasaModel updatedMasa = await apiService.MasaDoldur(
                                token: globalToken!, masaId: widget.masaId);
                            widget.updateMasaCallback(updatedMasa);
                            masadurum = true;
                          }
                        } catch (e) {
                          // Hata olduğunda bir AlertDialog ile mesaj göster
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hata!',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                content: Text(
                                  e.toString().replaceFirst('Exception: ', ''),
                                  style: TextStyle(
                                      fontSize:
                                          20), // "Exception: " kısmını temizle
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Tamam',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      splashColor: Colors.pinkAccent.withOpacity(0.3),
                      highlightColor: Colors.pink.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            masadurum == true ? Icons.close : Icons.add,
                            size: 30,
                            color: Colors.pinkAccent,
                          ),
                          SizedBox(height: 10),
                          Text(
                            masadurum == true ? 'Kapat' : 'Aç',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
