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
    return Padding(
        padding: padding,
        child: DynamicHeightGridView(
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
              margin: const EdgeInsets.all(10),
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.network(
                        "https://www.buseterim.com.tr/upload/default/2019/9/30/kahvehakkndabilmenizgerekenler1000.jpg",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "${urun.urunAdi}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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
                            size: 9,
                          ),
                        ),
                        Text(
                          '${urunSayaclari[urunId] ?? 0}',
                          style: TextStyle(fontSize: 11),
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
                            size: 9,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final masaUrunEkle = MasaUrunEkleModel(
                              urun: urun,
                              urunAdet: urunSayaclari[urunId],
                            );
                            MasaModel updatedMasa =
                                await apiService.postMasaUrunEkle(
                                    token: globalToken!,
                                    model: masaUrunEkle,
                                    id: widget.masaId);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Ürün başarıyla eklendi!")),
                            );
                            widget.updateMasaCallback(updatedMasa);
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
        ));
  }
}
