import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/models/global.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class UrunMasa extends StatefulWidget {
  final MasaModel masadeneme;
  final String masaId;
  final String alanId;
  const UrunMasa(
      {super.key,
      required this.masaId,
      required this.alanId,
      required this.masadeneme});

  @override
  State<UrunMasa> createState() => _UrunMasaState();
}

class _UrunMasaState extends State<UrunMasa> {
  ApiService apiService = ApiService();

  Decimal toplamFiyat = Decimal.zero;
  late MasaModel masa;
  late List<MasaIcerikModel> masaIcerikList;
  late List<int> urunSayaclari;
  int? selectedIndex; // Seçili satır için index
  Map<int, int> adetSayaclari = {}; // Her ürün için adet
  List<MasaIcerikSil> masaIcerikSilList = []; // Seçilen ürünlerin ID'leri
  MasaIcerikSil? masaiceriksil;
  Set<int> selectedIndexes =
      {}; // Seçili satırların index'lerini tutmak  için Set .

  bool showPaid = false; // true: Ödenenler, false: Ödenmeyenler

  @override
  void initState() {
    super.initState();
    masa = widget.masadeneme;
    masaIcerikList = masa.masaIcerikList ?? [];
    urunSayaclari = List.generate(masaIcerikList.length,
        (index) => masa.masaIcerikList![index].urunAdet ?? 1);
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    Decimal total = Decimal.zero;

    for (var icerik in masaIcerikList) {
      UrunlerModel urun = (icerik.urun != null) ? icerik.urun! : UrunlerModel();
      total += urun.fiyat! * Decimal.fromInt(icerik.urunAdet ?? 0);
    }

    setState(() {
      toplamFiyat = total;
    });
  }

  List<MasaIcerikModel> get filteredMasaIcerikList {
    if (showPaid) {
      return masaIcerikList
          .where((icerik) => icerik.odenmeDurumu == true)
          .toList();
    } else {
      return masaIcerikList
          .where((icerik) => icerik.odenmeDurumu == false)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showPaid = false;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: !showPaid
                                ? Colors.pinkAccent
                                : Colors.transparent,
                            foregroundColor:
                                !showPaid ? Colors.white : Colors.black,
                          ),
                          child: Text("Ödenmeyenler",
                              style: TextStyle(fontSize: 16)),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showPaid = true;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: showPaid
                                ? Colors.pinkAccent
                                : Colors.transparent,
                            foregroundColor:
                                showPaid ? Colors.white : Colors.black,
                          ),
                          child:
                              Text("Ödenenler", style: TextStyle(fontSize: 16)),
                        ),
                        SizedBox(width: 10),
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            masa.masaAdi ?? "-",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: filteredMasaIcerikList.length,
                    itemBuilder: (context, index) {
                      MasaIcerikModel icerik = filteredMasaIcerikList[index];
                      UrunlerModel urun =
                          (icerik.urun != null) ? icerik.urun! : UrunlerModel();

                      return Column(
                        children: [
                          divider(),
                          GestureDetector(
                            onLongPress: () {
                              setState(() {
                                masaiceriksil = MasaIcerikSil();
                                masaiceriksil?.id = icerik.id;
                                masaiceriksil?.urun = icerik.urun;
                                masaiceriksil?.urunAdet = icerik.urunAdet;
                                if (masaIcerikSilList.contains(masaiceriksil) ||
                                    selectedIndexes.contains(index)) {
                                  masaIcerikSilList.remove(masaiceriksil);
                                  selectedIndexes.remove(index);
                                } else {
                                  masaIcerikSilList.add(masaiceriksil!);
                                  selectedIndexes.add(index);
                                }
                              });
                            },
                            onTap: () {
                              setState(() {
                                selectedIndex =
                                    selectedIndex == index ? null : index;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: icerik.odenmeDurumu == true
                                    ? Colors.grey[300] // Ödenmişse gri renk
                                    : (selectedIndexes.contains(
                                            index) // Seçili satır mı kontrolü
                                        ? Colors
                                            .blue[100] // Seçili satırın rengi
                                        : Colors
                                            .white), // Diğer satırların rengi

                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Metinleri sola hizala

                                    children: [
                                      Text(
                                        " ${icerik.urunAdet}x",
                                        style: const TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      if (adetSayaclari.containsKey(index) &&
                                          adetSayaclari[index]! > 0)
                                        Text(
                                          "-${adetSayaclari[index]}x",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    urun.urunAdi ?? "Ürün Bilinmiyor",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(198, 0, 0, 0)),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "₺${(((urun.fiyat as Decimal).toDouble()) * ((icerik.urunAdet as int))).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(181, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (selectedIndex == index) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              color: Colors.grey[100],
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if ((adetSayaclari[index] ?? 1) > 1) {
                                          adetSayaclari[index] =
                                              (adetSayaclari[index] ?? 1) - 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.remove,
                                        color: Colors.pinkAccent),
                                  ),
                                  Text(
                                      "${adetSayaclari[index] ?? 1}"), // Null ise 1 olarak göster
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if ((adetSayaclari[index] ?? 1) <
                                            icerik.urunAdet!) {
                                          adetSayaclari[index] =
                                              (adetSayaclari[index] ?? 1) + 1;
                                        }
                                      });
                                    },
                                    icon: Icon(Icons.add,
                                        color: Colors.pinkAccent),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (adetSayaclari[index] == null) {
                                          adetSayaclari[index] = 1;
                                          masaiceriksil = MasaIcerikSil();
                                          masaiceriksil?.id = icerik.id;
                                          masaiceriksil?.urun = icerik.urun;
                                          masaiceriksil?.urunAdet =
                                              adetSayaclari[index];
                                          if (masaIcerikSilList
                                                  .contains(masaiceriksil) ||
                                              selectedIndexes.contains(index)) {
                                            masaIcerikSilList
                                                .remove(masaiceriksil);
                                            selectedIndexes.remove(index);
                                          } else {
                                            masaIcerikSilList
                                                .add(masaiceriksil!);
                                            selectedIndexes.add(index);
                                          } // Null ise 1 olarak ayarla
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent,
                                    ),
                                    child: Text("Ayır"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        apiService.putMasaIcerikOde(
                            token: globalToken!,
                            model: masaIcerikSilList,
                            id: widget.masaId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 18),
                      ),
                      child: const Text(
                        "ÖDEME AL",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "₺${toplamFiyat.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(
      color: Colors.grey,
      thickness: 2,
      indent: 10,
      endIndent: 10,
    );
  }
}
