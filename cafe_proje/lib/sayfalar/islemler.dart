import 'package:cafe_proje/sayfalar/main.dart';
import 'package:cafe_proje/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:cafe_proje/models/global.dart';

class Islemler extends StatelessWidget {
  final String masaId;
  final bool? masaDurumu;
  const Islemler({super.key, required this.masaId, required this.masaDurumu});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                print("tıklandı");
              },
              splashColor: Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
              highlightColor: Colors.pink.withOpacity(0.10), // Tıklama vurgusu
              borderRadius: BorderRadius.circular(10),
              child: const Column(
                mainAxisSize: MainAxisSize
                    .min, // Bu, Column'un minimum alanda yer kaplamasını sağlar
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.card_giftcard_sharp,
                    size: 30,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'İkram',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                print("tıklandı2");
              },
              splashColor: Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
              highlightColor: Colors.pink.withOpacity(0.10), // Tıklama vurgusu
              borderRadius: BorderRadius.circular(10),
              child: const Column(
                mainAxisSize: MainAxisSize
                    .min, // Bu, Column'un minimum alanda yer kaplamasını sağlar
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    size: 30,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'İade',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                print("tıklandı3");
              },
              splashColor: Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
              highlightColor: Colors.pink.withOpacity(0.10), // Tıklama vurgusu
              borderRadius: BorderRadius.circular(10),
              child: const Column(
                mainAxisSize: MainAxisSize
                    .min, // Bu, Column'un minimum alanda yer kaplamasını sağlar
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_outward_sharp,
                    size: 30,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Böl',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                print("tıklandı3");
              },
              splashColor: Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
              highlightColor: Colors.pink.withOpacity(0.10), // Tıklama vurgusu
              borderRadius: BorderRadius.circular(10),
              child: const Column(
                mainAxisSize: MainAxisSize
                    .min, // Bu, Column'un minimum alanda yer kaplamasını sağlar
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.print,
                    size: 30,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Yazdır',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                print("tıklandı4");
              },
              splashColor: Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
              highlightColor: Colors.pink.withOpacity(0.10), // Tıklama vurgusu
              borderRadius: BorderRadius.circular(10),
              child: const Column(
                mainAxisSize: MainAxisSize
                    .min, // Bu, Column'un minimum alanda yer kaplamasını sağlar
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'İptal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              splashColor: Colors.pinkAccent.withOpacity(0.3), // Dalga rengi
              highlightColor: Colors.pink.withOpacity(0.10), // Tıklama vurgusu
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
                  if (masaDurumu == true) {
                    await apiService.kapatMasa(
                        token: globalToken!, masaId: masaId);
                  } else {
                    await apiService.MasaDoldur(
                        token: globalToken!, masaId: masaId);
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
                              fontSize: 20), // "Exception: " kısmını temizle
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
                    masaDurumu == true ? Icons.close : Icons.add,
                    size: 30,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    masaDurumu == true ? 'Kapat' : 'Doldur',
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
