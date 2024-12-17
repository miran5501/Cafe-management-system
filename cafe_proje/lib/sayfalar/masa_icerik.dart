import 'dart:convert';

import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/models/global.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class UrunMasa extends StatefulWidget {
  final MasaModel masadeneme;
  final String masaId;
  final String alanId;
  final Function(MasaModel) updateMasaCallback; // Callback
  const UrunMasa(
      {super.key,
      required this.masaId,
      required this.alanId,
      required this.masadeneme,
      required this.updateMasaCallback});

  @override
  State<UrunMasa> createState() => _UrunMasaState();
}

class _UrunMasaState extends State<UrunMasa> {
  ApiService apiService = ApiService();

  Decimal anlikTutar = Decimal.zero;
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              style: TextStyle(fontSize: 14)),
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
                              Text("Ödenenler", style: TextStyle(fontSize: 14)),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10),
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
                              fontSize: 18,
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
                      String urunadi;
                      try {
                        // UTF-8 çözümlemesi yapılabiliyorsa uygula
                        urunadi = utf8.decode(urun.urunAdi!.codeUnits,
                            allowMalformed: false);
                      } catch (e) {
                        // Hata oluşursa zaten çözülmüş olduğu anlamına gelir
                        urunadi = urun.urunAdi!;
                      }

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
                                  final urun = masaiceriksil!.urun;
                                  final urunAdet = masaiceriksil?.urunAdet;

                                  if (urun != null && urunAdet != null) {
                                    anlikTutar -=
                                        urun.fiyat! * Decimal.fromInt(urunAdet);
                                  }

                                  masaIcerikSilList.remove(masaiceriksil);
                                  selectedIndexes.remove(index);
                                } else {
                                  final urun = masaiceriksil!.urun;
                                  final urunAdet = masaiceriksil?.urunAdet;
                                  masaIcerikSilList.add(masaiceriksil!);
                                  selectedIndexes.add(index);
                                  if (urun != null && urunAdet != null) {
                                    anlikTutar +=
                                        urun.fiyat! * Decimal.fromInt(urunAdet);
                                  }
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
                                        ? const Color.fromARGB(255, 216, 199,
                                            241) // Seçili satırın rengi
                                        : Colors
                                            .white), // Diğer satırların rengi
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: adetSayaclari
                                                .containsKey(index) &&
                                            adetSayaclari[index]! > 0
                                        ? MainAxisAlignment
                                            .spaceBetween // Eğer alttaki text varsa
                                        : MainAxisAlignment
                                            .center, // Eğer alttaki text yoksa ortala
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start, // Sola hizala
                                    children: [
                                      Text(
                                        " ${icerik.urunAdet}x",
                                        style: const TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      adetSayaclari.containsKey(index) &&
                                              adetSayaclari[index]! > 0
                                          ? Text(
                                              "-${adetSayaclari[index]}x",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            )
                                          : const SizedBox
                                              .shrink(), // Eğer koşul sağlanmazsa boş widget
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    urunadi,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(198, 0, 0, 0)),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        "₺${(((urun.fiyat as Decimal).toDouble()) * ((icerik.urunAdet as int))).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(181, 0, 0, 0),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${icerik.urunEklenmeTarihi?.add(const Duration(hours: 3)).hour}:${icerik.urunEklenmeTarihi?.add(const Duration(hours: 3)).minute.toString().padLeft(2, '0')}",
                                          ),
                                          icerik.odenmeDurumu != null &&
                                                  icerik.odenmeDurumu!
                                              ? Text(
                                                  " / ${icerik.urunKaldirilmaTarihi?.add(const Duration(hours: 3)).hour}:${icerik.urunKaldirilmaTarihi?.add(const Duration(hours: 3)).minute.toString().padLeft(2, '0')}")
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ],
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
                                            final urun = masaiceriksil!.urun;
                                            final urunAdet =
                                                masaiceriksil?.urunAdet;

                                            if (urun != null &&
                                                urunAdet != null) {
                                              anlikTutar -= urun.fiyat! *
                                                  Decimal.fromInt(urunAdet);
                                            }

                                            selectedIndexes.remove(index);
                                          } else {
                                            masaIcerikSilList
                                                .add(masaiceriksil!);
                                            final urun = masaiceriksil!.urun;
                                            final urunAdet =
                                                masaiceriksil?.urunAdet;

                                            if (urun != null &&
                                                urunAdet != null) {
                                              anlikTutar += urun.fiyat! *
                                                  Decimal.fromInt(urunAdet);
                                            }
                                            selectedIndexes.add(index);
                                          } // Null ise 1 olarak ayarla
                                        } else {
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
                                            final urun = masaiceriksil!.urun;
                                            final urunAdet =
                                                masaiceriksil?.urunAdet;

                                            if (urun != null &&
                                                urunAdet != null) {
                                              anlikTutar -= urun.fiyat! *
                                                  Decimal.fromInt(urunAdet);
                                            }
                                            selectedIndexes.remove(index);
                                          } else {
                                            masaIcerikSilList
                                                .add(masaiceriksil!);
                                            final urun = masaiceriksil!.urun;
                                            final urunAdet =
                                                masaiceriksil?.urunAdet;

                                            if (urun != null &&
                                                urunAdet != null) {
                                              anlikTutar += urun.fiyat! *
                                                  Decimal.fromInt(urunAdet);
                                            }
                                            selectedIndexes.add(index);
                                          } // Null ise 1 olarak ayarlas
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
                      onPressed: () async {
                        MasaModel updatedMasa =
                            await apiService.putMasaIcerikOde(
                                token: globalToken!,
                                model: masaIcerikSilList,
                                id: widget.masaId);

                        widget.updateMasaCallback(updatedMasa);
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
                      "₺${anlikTutar.toStringAsFixed(2) ?? '0.00'}", // 2 basamaklı gösterim
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 96, 95, 96),
                      ),
                    ),
                    Text(
                      "₺${masa.toplamTutar?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(
                        fontSize: 25,
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
    return const Divider(
      color: Colors.grey,
      thickness: 2,
    );
  }
}
