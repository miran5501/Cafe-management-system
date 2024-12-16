import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/models/global.dart';
import 'package:flutter/material.dart';
import 'package:cafe_proje/sayfalar/masa_sayfasi.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:dynamic_height_list_view/dynamic_height_view.dart';

class Masalar extends StatefulWidget {
  final Function(String id)?
      onSelected; // Tıklanan alanın ID'sini geri döndürmek için callback

  final String selectedId; // Seçilen ID'yi dışarıdan alıyoruz

  const Masalar({super.key, required this.selectedId, this.onSelected});

  @override
  State<Masalar> createState() => _MasalarState();
}

class _MasalarState extends State<Masalar> {
  late MasaModel masaById;
  @override
  Widget build(BuildContext context) {
    String id = "";
    ApiService apiService = ApiService();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: apiService.getMasa(
            token: globalToken!,
            id: widget.selectedId), // ID'yi widget üzerinden alıyoruz
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return DynamicHeightGridView(
              shrinkWrap: true,
              itemCount:
                  snapshot.data!.length, // Veritabanından alınan masa sayısı
              crossAxisCount: 6, // Her satırda 6 kart
              mainAxisSpacing: 10,
              builder: (context, index) {
                final masa = snapshot.data?[index];
                return InkWell(
                  onTap: () async {
                    setState(() {
                      id = snapshot.data![index].id.toString();
                    });
                    masaById = await apiService.getMasaById(
                        token: globalToken!, masaId: id);

                    // Callback ile ID'yi geri döndür
                    if (widget.onSelected != null) {
                      widget.onSelected!(id);
                    }

                    // Sayfa geçişi
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MasaSayfasi(
                                alanId: widget.selectedId,
                                masaId: id,
                                masa: masaById,
                              )),
                    );
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: masa.masaDurumu
                          ? const Color.fromARGB(255, 240, 160, 160)
                          : const Color.fromARGB(
                              255, 255, 255, 255), // Duruma göre renk
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${masa.masaAdi}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18.0),
                        ),
                        Text("${masa.masaDurumu ? ' Dolu' : 'Boş '}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Veri yükleniyor");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
