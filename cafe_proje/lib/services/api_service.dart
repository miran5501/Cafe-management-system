import 'dart:convert';
import 'package:cafe_proje/models/alanlar_model.dart';
import 'package:cafe_proje/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // UTF-8 ile çözümleme fonksiyonu
  String _decodeResponseBody(String body) {
    return utf8.decode(body.codeUnits);
  }

  // Alanlar verilerini çekme
  Future<List<AlanlarModel>> getAlanlar({required TokenModel token}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    final response = await http.get(Uri.parse(urlAlanlar), headers: headers);

    List<AlanlarModel> alanlar = [];

    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      List<dynamic> responseList = jsonDecode(decodedBody);

      for (var i = 0; i < responseList.length; i++) {
        alanlar.add(AlanlarModel.fromJson(responseList[i]));
      }
      return alanlar;
    } else {
      throw Exception('API Hatası: ${response.statusCode}');
    }
  }

  // Masa verilerini çekme
  Future<List<MasaModel>> getMasa(
      {required TokenModel token, required String id}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    String url;
    if (id.isEmpty) {
      url = urlTumMasalar;
    } else {
      url = urlMasa + id;
    }

    final response = await http.get(Uri.parse(url), headers: headers);

    List<MasaModel> masa = [];

    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      dynamic responseIcerik = jsonDecode(decodedBody);
      List masalar = [];

      if (id.isEmpty) {
        masalar = responseIcerik;
      } else {
        masalar = responseIcerik['masalar'];
      }
      for (var i = 0; i < masalar.length; i++) {
        masa.add(MasaModel.fromJson(masalar[i]));
      }
      return masa;
    } else {
      String decodedBody = _decodeResponseBody(response.body);
      Map<String, dynamic> errorResponse = jsonDecode(decodedBody);
      ApiError error = ApiError.fromJson(errorResponse);

      throw Exception(error.message);
    }
  }

  // modelgori verilerini çekme
  Future<List<KategoriModel>> getKategori({required TokenModel token}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    final response = await http.get(Uri.parse(urlKategori), headers: headers);

    List<KategoriModel> kategori = [];

    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      List<dynamic> responseList = jsonDecode(decodedBody);

      for (var i = 0; i < responseList.length; i++) {
        kategori.add(KategoriModel.fromJson(responseList[i]));
      }
      return kategori;
    } else {
      String decodedBody = _decodeResponseBody(response.body);
      Map<String, dynamic> errorResponse = jsonDecode(decodedBody);
      ApiError error = ApiError.fromJson(errorResponse);

      throw Exception(error.message);
    }
  }

  // Urun verilerini çekme
  Future<List<UrunlerModel>> getUrun(
      {required TokenModel token, required String id}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    String url;
    if (id.isEmpty) {
      url = urlTumUrunler;
    } else {
      url = urlUrun + id;
    }

    final response = await http.get(Uri.parse(url), headers: headers);

    List<UrunlerModel> urun = [];

    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      List<dynamic> responseList = jsonDecode(decodedBody);

      for (var i = 0; i < responseList.length; i++) {
        urun.add(UrunlerModel.fromJson(responseList[i]));
      }
      return urun;
    } else {
      String decodedBody = _decodeResponseBody(response.body);
      Map<String, dynamic> errorResponse = jsonDecode(decodedBody);
      ApiError error = ApiError.fromJson(errorResponse);

      throw Exception(error.message);
    }
  }

  // Masa Ürün Ekleme
  Future<MasaModel> postMasaUrunEkle(
      {required TokenModel token,
      required MasaUrunEkleModel model,
      required String id}) async {
    String? accessToken = token.accessToken;

    final url = Uri.parse(urlMasaUrunEkle + id);

    final response = await http.post(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: json.encode(
        model.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      print("Başarılı: ${response.body}");
      return MasaModel.fromJson(json.decode(response.body));
    } else {
      // Gelen cevaptaki hatayı parse et
      var responseBody =
          utf8.decode(response.bodyBytes); // UTF-8 ile decode ediyoruz
      var parsedResponse = json.decode(responseBody); // JSON'u çözümle
      var errorMessage = parsedResponse['exception']?['message'] ??
          'Bilinmeyen bir hata oluştu'; // Hata mesajını alıyoruz
      throw Exception(errorMessage); // Hata mesajını fırlatıyoruz
    }
  }

  // Masa Bilgisi
  Future<MasaModel> getMasaById(
      {required TokenModel token, required String masaId}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    final response =
        await http.get(Uri.parse(urlMasaById + masaId), headers: headers);

    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      final Map<String, dynamic> responseJson = jsonDecode(decodedBody);
      return MasaModel.fromJson(responseJson);
    } else {
      // Gelen cevaptaki hatayı parse et
      var responseBody =
          utf8.decode(response.bodyBytes); // UTF-8 ile decode ediyoruz
      var parsedResponse = json.decode(responseBody); // JSON'u çözümle
      var errorMessage = parsedResponse['exception']?['message'] ??
          'Bilinmeyen bir hata oluştu'; // Hata mesajını alıyoruz
      throw Exception(errorMessage); // Hata mesajını fırlatıyoruz
    }
  }

  Future<MasaModel> kapatMasa(
      {required TokenModel token, required String masaId}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    final response =
        await http.put(Uri.parse(urlmasaKapat + masaId), headers: headers);

    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      final Map<String, dynamic> responseJson = jsonDecode(decodedBody);
      return MasaModel.fromJson(responseJson);
    } else {
      // Gelen cevaptaki hatayı parse et
      var responseBody =
          utf8.decode(response.bodyBytes); // UTF-8 ile decode ediyoruz
      var parsedResponse = json.decode(responseBody); // JSON'u çözümle
      var errorMessage = parsedResponse['exception']?['message'] ??
          'Bilinmeyen bir hata oluştu'; // Hata mesajını alıyoruz
      throw Exception(errorMessage); // Hata mesajını fırlatıyoruz
    }
  }

  // Masa Doldurma
  Future<MasaModel> MasaDoldur(
      {required TokenModel token, required String masaId}) async {
    String? accessToken = token.accessToken;
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken", // Token'i burada ekliyoruz
    };
    final response =
        await http.put(Uri.parse(urlmasaDoldur + masaId), headers: headers);
    if (response.statusCode == 200) {
      String decodedBody = _decodeResponseBody(response.body);
      final Map<String, dynamic> responseJson = jsonDecode(decodedBody);
      return MasaModel.fromJson(responseJson);
    } else {
      throw Exception('API Hatası: ${response.statusCode}');
    }
  }

  Future<MasaModel> putMasaIcerikOde(
      {required TokenModel token,
      required List<MasaIcerikSil> model,
      required String id}) async {
    String? accessToken = token.accessToken;

    final url = Uri.parse(urlMasaIcerikSil + id);

    final response = await http.put(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: json.encode(model
          .map((item) => item.toJson())
          .toList()), // Listeyi JSON'a dönüştür
    );

    if (response.statusCode == 200) {
      print("Başarılı: ${response.body}");
      return MasaModel.fromJson(
          json.decode(response.body)); // Gelen cevabı parse et ve döndür
    } else {
      throw Exception('API Hatası: ${response.statusCode}');
    }
  }

  Future<TokenModel> postGirisYap(String username, String password) async {
    final url = Uri.parse(urlGiris);

    final response = await http.post(
      url,
      headers: <String, String>{
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      print("Başarılı: ${response.body}");
      return TokenModel.fromJson(json.decode(response.body));
    } else {
      var responseBody =
          utf8.decode(response.bodyBytes); // UTF-8 ile decode ediyoruz
      var parsedResponse = json.decode(responseBody); // JSON'u çözümle
      var errorMessage = parsedResponse['exception']?['message'] ??
          'Bilinmeyen bir hata oluştu'; // Hata mesajını alıyoruz
      throw Exception(errorMessage);
    }
  }
}
