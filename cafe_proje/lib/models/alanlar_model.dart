import 'package:decimal/decimal.dart';

class AlanlarModel {
  String? id;
  String? alanIsmi;

  AlanlarModel({this.id, this.alanIsmi});

  AlanlarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alanIsmi = json['alanIsmi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['alanIsmi'] = alanIsmi;
    return data;
  }
}

class MasaModel {
  String? id;
  String? alanId;
  String? masaAdi;
  bool? masaDurumu;
  List<MasaIcerikModel>? masaIcerikList;

  MasaModel({
    this.id,
    this.alanId,
    this.masaAdi,
    this.masaDurumu,
    this.masaIcerikList,
  });

  // JSON'dan model oluşturma
  MasaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alanId = json['alanId'];
    masaAdi = json['masaAdi'];
    masaDurumu = json['masaDurumu'];

    // masaIcerikList'i JSON'dan almak
    if (json['masaIcerikList'] != null) {
      masaIcerikList = <MasaIcerikModel>[];
      json['masaIcerikList'].forEach((v) {
        masaIcerikList!.add(MasaIcerikModel.fromJson(v));
      });
    }
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['alanId'] = alanId;
    data['masaAdi'] = masaAdi;
    data['masaDurumu'] = masaDurumu;

    // masaIcerikList'i JSON'a dönüştürme
    if (masaIcerikList != null) {
      data['masaIcerikList'] = masaIcerikList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KategoriModel {
  String? id;
  String? kategoriIsmi;

  KategoriModel({this.id, this.kategoriIsmi});

  KategoriModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategoriIsmi = json['kategoriIsmi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kategoriIsmi'] = kategoriIsmi;
    return data;
  }
}

class MasaIcerikModel {
  String? id;
  UrunlerModel? urun;
  int? urunAdet;
  DateTime? urunEklenmeTarihi;
  DateTime? urunKaldirilmaTarihi;
  bool? odenmeDurumu;

  MasaIcerikModel({
    this.id,
    this.urun,
    this.urunAdet,
    this.urunEklenmeTarihi,
    this.urunKaldirilmaTarihi,
    this.odenmeDurumu,
  });

  // JSON'dan model oluşturma
  MasaIcerikModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urun = json['urun'] != null ? UrunlerModel.fromJson(json['urun']) : null;
    urunAdet = json['urunAdet'];
    urunEklenmeTarihi = json['urunEklenmeTarihi'] != null
        ? DateTime.parse(json['urunEklenmeTarihi'])
        : null;
    urunKaldirilmaTarihi = json['urunKaldirilmaTarihi'] != null
        ? DateTime.parse(json['urunKaldirilmaTarihi'])
        : null;
    odenmeDurumu = json['odenmeDurumu'];
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (urun != null) {
      data['urun'] = urun!.toJson(); // `urun` alanını JSON'a dönüştürme
    }
    data['urunAdet'] = urunAdet;
    data['urunEklenmeTarihi'] =
        urunEklenmeTarihi?.toIso8601String(); // DateTime'ı string'e dönüştürme
    data['urunKaldirilmaTarihi'] = urunKaldirilmaTarihi
        ?.toIso8601String(); // DateTime'ı string'e dönüştürme
    data['odenmeDurumu'] = odenmeDurumu;
    return data;
  }
}

class UrunlerModel {
  String? id;
  String? urunAdi;
  Decimal? fiyat; // `fiyat` alanını Decimal türüne dönüştürmek
  int? stok;
  String? kategoriId;

  UrunlerModel({this.id, this.urunAdi, this.fiyat, this.stok, this.kategoriId});

  // JSON'dan model oluşturma
  UrunlerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urunAdi = json['urunAdi'];
    fiyat = json['fiyat'] != null
        ? Decimal.parse(json['fiyat'].toString())
        : null; // JSON'dan Decimal'e dönüştürme
    stok = json['stok'];
    kategoriId = json['kategoriId'];
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['urunAdi'] = urunAdi;
    data['fiyat'] = fiyat?.toString(); // Decimal'i String'e dönüştürme
    data['stok'] = stok;
    data['kategoriId'] = kategoriId;
    return data;
  }
}

class MasaUrunEkleModel {
  UrunlerModel? urun;
  int? urunAdet;

  MasaUrunEkleModel({this.urun, this.urunAdet});

  // JSON'dan model oluşturma
  MasaUrunEkleModel.fromJson(Map<String, dynamic> json) {
    urun = json['urun'] != null ? UrunlerModel.fromJson(json['urun']) : null;
    urunAdet = json['urunAdet'];
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (urun != null) {
      data['urun'] = urun!.toJson(); // `urun` alanını JSON'a dönüştürme
    }
    data['urunAdet'] = urunAdet;
    return data;
  }
}

class ApiError {
  final String message;
  final String path;
  final String hostName;
  final int status;

  ApiError({
    required this.message,
    required this.path,
    required this.hostName,
    required this.status,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['exception']['message'] ?? 'Bilinmeyen hata',
      path: json['exception']['path'] ?? '',
      hostName: json['exception']['hostName'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}

class MasaIcerikSil {
  String? id;
  UrunlerModel? urun;
  int? urunAdet;

  MasaIcerikSil({this.id, this.urun, this.urunAdet});

  // JSON'dan model oluşturma
  MasaIcerikSil.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urun = json['urun'] != null ? UrunlerModel.fromJson(json['urun']) : null;
    urunAdet = json['urunAdet'];
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (urun != null) {
      data['urun'] = urun!.toJson(); // `urun` alanını JSON'a dönüştürme
    }
    data['urunAdet'] = urunAdet;
    return data;
  }
}

class KullaniciModel {
  String? username;
  String? password;

  KullaniciModel({this.username, this.password});

  // JSON'dan model oluşturma
  KullaniciModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class TokenModel {
  String? accessToken;
  String? refreshToken;

  TokenModel({this.accessToken, this.refreshToken});

  // JSON'dan model oluşturma
  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  // Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
