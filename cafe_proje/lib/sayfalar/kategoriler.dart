import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:flutter/material.dart';

class Kategori extends StatefulWidget {
  final List<KategoriModel> kategoriList;
  final Function(String) onKategoriSelected;
  const Kategori(
      {super.key,
      required this.kategoriList,
      required this.onKategoriSelected});

  @override
  State<Kategori> createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  // Kategori id'sini saklamak için bir değişken.
  String kategoriId = "";

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            height: deviceHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF3B1E54),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                // Menüler başlığı
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20), // İç boşluk
                  child: Text(
                    "Menüler",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Kategori Listesi
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        widget.kategoriList.length, // kategoriList kullanılıyor
                    itemBuilder: (context, index) {
                      bool isSelected = kategoriId ==
                          widget.kategoriList[index].id.toString();

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            kategoriId =
                                widget.kategoriList[index].id.toString();
                          });
                          widget.onKategoriSelected(kategoriId);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0XFFEEEEEE)
                                : const Color(0xFF3B1E54),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(-205),
                              bottomLeft: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 169, 169, 169)
                                    .withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.kategoriList[index].kategoriIsmi
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.black
                                      : const Color(0XFFEEEEEE),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
