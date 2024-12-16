import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const SifreTekrarSayfasi());
}

class SifreTekrarSayfasi extends StatelessWidget {
  const SifreTekrarSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SifreSayfasi(),
    );
  }
}

class SifreSayfasi extends StatefulWidget {
  const SifreSayfasi({super.key});

  @override
  State<SifreSayfasi> createState() => _SifreSayfasiState();
}

class _SifreSayfasiState extends State<SifreSayfasi> {
  final TextEditingController yeniSifre1 = TextEditingController();
  final TextEditingController yeniSifre2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // Sol Şifre Değişikliği Formu
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Şifre Değiştir",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: true,
                      controller: yeniSifre2,
                      decoration: InputDecoration(
                        labelText: 'Yeni Şifre',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      obscureText: true,
                      controller: yeniSifre2,
                      decoration: InputDecoration(
                        labelText: 'Yeni Şifre',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Değiştir Butonu
                    ElevatedButton(
                      onPressed: () {
                        // Şifre değiştirme işlemi burada yapılır
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Şifre Değiştir",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sağ: Görsel Alanı
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                        "assets/resimler/sifresayfasi.png"), // Görseli buraya ekle
                    fit: BoxFit.contain,
                  ),
                  color:
                      Colors.purple.withOpacity(0.1), // Hafif arkaplan efekti
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
