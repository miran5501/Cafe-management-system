import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/models/global.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_height_list_view/dynamic_height_view.dart';
import 'package:cafe_proje/utils/constants/const.dart';

class Urunler extends StatefulWidget {
  final List<UrunlerModel> urunList;
  final String kategoriId;
  final String masaId;
  final Function(MasaModel) updateMasaCallback; // Callback

  const Urunler({
    super.key,
    required this.kategoriId,
    required this.masaId,
    required this.urunList,
    required this.updateMasaCallback,
  });

  @override
  State<Urunler> createState() => _UrunlerState();
}

class _UrunlerState extends State<Urunler> {
  ApiService apiService = ApiService();
  Map<String, int> urunSayaclari = {}; // Her ürün icin sayac tutan yapı

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
      shrinkWrap: true,
      itemCount: widget.urunList.length,
      crossAxisCount: 3,
      mainAxisSpacing: 5,
      builder: (context, index) {
        final urun = widget.urunList[index];
        String urunId = urun.id ?? '';

        if (!urunSayaclari.containsKey(urunId!)) {
          urunSayaclari[urunId!] = 1;
        }

        return Container(
          height: 315,
          margin: const EdgeInsets.only(bottom: 0, top: 3, left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    urun.resim ??
                        'https://cdn.myikas.com/images/7bf9f6ea-e6e7-41f9-b991-d755e9ad2864/3f32cad7-1c51-4593-bb3a-8f035974c1b4/image_1080.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error,
                            color: Colors.red), // Hata ikonu gösterir
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Flexible(
                  child: Text(
                    "${urun.urunAdi}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  "₺${urun.fiyat}",
                  style: const TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (urunSayaclari[urunId]! > 1) {
                            urunSayaclari[urunId] =
                                (urunSayaclari[urunId] ?? 0) - 1;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.pinkAccent,
                        size: 13,
                      ),
                    ),
                    Container(
                      width: 0,
                      child: Text(
                        '${urunSayaclari[urunId] ?? 0}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          urunSayaclari[urunId] =
                              (urunSayaclari[urunId] ?? 0) + 1;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.pinkAccent,
                        size: 13,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final masaUrunEkle = MasaUrunEkleModel(
                            urun: urun,
                            urunAdet: urunSayaclari[urunId],
                          );
                          MasaModel updatedMasa =
                              await apiService.postMasaUrunEkle(
                                  token: globalToken!,
                                  model: masaUrunEkle,
                                  id: widget.masaId);
                          urunSayaclari[urunId] = 1;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Ürün başarıyla eklendi!")),
                          );
                          widget.updateMasaCallback(updatedMasa);
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(20, 35),
                      ),
                      child: const Text(
                        "Ekle",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
