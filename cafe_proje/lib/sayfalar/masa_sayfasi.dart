import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/models/global.dart';
import 'package:cafe_proje/sayfalar/kategoriler.dart';
import 'package:cafe_proje/sayfalar/masa_icerik.dart';
import 'package:cafe_proje/sayfalar/urunler.dart';
import 'package:cafe_proje/sayfalar/islemler.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:flutter/material.dart';

class MasaSayfasi extends StatefulWidget {
  final String masaId;
  final String alanId;
  final MasaModel masa;

  const MasaSayfasi(
      {super.key,
      required this.masaId,
      required this.alanId,
      required this.masa});

  @override
  State<MasaSayfasi> createState() => _KategoriState();
}

class _KategoriState extends State<MasaSayfasi> {
  String kategoriId = "";
  ApiService apiService = ApiService();
  List<KategoriModel> kategoriList = [];
  List<UrunlerModel> urunList = [];
  List<MasaIcerikModel> masaIcerikList = [];
  late MasaModel masa;
  late bool masaDurumu = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Kategorileri asenkron olarak almak için veri çekme işlemi başlatılıyor.
    _getKategoriList();
    _getUrunList(kategoriId);
    masaIcerikList = widget.masa.masaIcerikList ?? [];
    masa = widget.masa;
    masaDurumu = masa.masaDurumu ?? false;
  }

  void updateMasa(MasaModel updatedMasa) {
    setState(() {
      masa = updatedMasa;
    });
  }

  // Asenkron veri çekme işlemi
  Future<void> _getKategoriList() async {
    try {
      List<KategoriModel> fetchedKategoriList =
          await apiService.getKategori(token: globalToken!);
      setState(() {
        kategoriList = fetchedKategoriList;
        isLoading = false;
      });
    } catch (e) {
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
              style: const TextStyle(
                  fontSize: 20), // "Exception: " kısmını temizle
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Tamam',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _getUrunList(String kategoriId) async {
    try {
      List<UrunlerModel> fetchedUrunList =
          await apiService.getUrun(token: globalToken!, id: kategoriId);
      setState(() {
        urunList = fetchedUrunList;
      });
    } catch (e) {
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
              style: const TextStyle(
                  fontSize: 20), // "Exception: " kısmını temizle
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Tamam',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height - 30;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            color: Color(0XFFEEEEEE),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: deviceHeight,
                          color: Color(0XFFEEEEEE),
                          padding: const EdgeInsets.only(top: 28.0, bottom: 0),
                          child: Islemler(
                              masaId: widget.masaId, masaDurumu: masaDurumu)),
                    ),
                    widget.masaId.isNotEmpty
                        ? Expanded(
                            flex: 4,
                            child: Container(
                              height: deviceHeight,
                              color: Color(0XFFEEEEEE),
                              padding:
                                  const EdgeInsets.only(top: 28.0, bottom: 0),
                              child: UrunMasa(
                                key: ValueKey(masa.masaIcerikList),
                                masaId: widget.masaId,
                                alanId: widget.alanId,
                                masadeneme: masa,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: deviceHeight,
                        color: Color(0XFFEEEEEE),
                        child: Urunler(
                          kategoriId: kategoriId,
                          masaId: widget.masaId,
                          urunList: urunList,
                          updateMasaCallback: updateMasa,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                          height: deviceHeight,
                          color: Color(0XFFEEEEEE),
                          padding: const EdgeInsets.only(top: 28.0, bottom: 0),
                          child: Kategori(
                            kategoriList: kategoriList,
                            onKategoriSelected: (id) {
                              setState(() {
                                kategoriId = id; // Kategori ID'sini al
                                _getUrunList(kategoriId);
                              });
                            },
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
