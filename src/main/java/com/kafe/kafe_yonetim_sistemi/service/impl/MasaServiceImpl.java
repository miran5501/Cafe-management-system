package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoMasa;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaGuncelle;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIcerik;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIcerikIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIcerikOde;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrun;
import com.kafe.kafe_yonetim_sistemi.entities.Alan;
import com.kafe.kafe_yonetim_sistemi.entities.GecmisMasa;
import com.kafe.kafe_yonetim_sistemi.entities.GecmisMasaIcerik;
import com.kafe.kafe_yonetim_sistemi.entities.Masa;
import com.kafe.kafe_yonetim_sistemi.entities.MasaIcerik;
import com.kafe.kafe_yonetim_sistemi.entities.Urun;
import com.kafe.kafe_yonetim_sistemi.exception.BaseException;
import com.kafe.kafe_yonetim_sistemi.exception.ErrorMessage;
import com.kafe.kafe_yonetim_sistemi.exception.MessageType;
import com.kafe.kafe_yonetim_sistemi.repository.AlanRepository;
import com.kafe.kafe_yonetim_sistemi.repository.GecmisMasaRepository;
import com.kafe.kafe_yonetim_sistemi.repository.MasaRepository;
import com.kafe.kafe_yonetim_sistemi.repository.UrunRepository;
import com.kafe.kafe_yonetim_sistemi.service.IMasaService;

@Service
public class MasaServiceImpl implements IMasaService {

    @Autowired
    private MasaRepository masaRepository;

    @Autowired
    private AlanRepository alanRepository;

    @Autowired
    private UrunRepository urunRepository;

    @Autowired
    private GecmisMasaRepository gecmisMasaRepository;

    @Override
    public List<DtoMasa> getAllMasa() {
        List<DtoMasa> dtoMasaList = new ArrayList<>();
        List<Masa> masaList = masaRepository.findAll();
        if (masaList != null && !masaList.isEmpty()) {
            for (Masa masa : masaList) {
                DtoMasa dtoMasa = new DtoMasa();
                List<MasaIcerik> masaIcerikList = masa.getMasaIcerikList();
                List<DtoMasaIcerik> dtoMasaIcerikList = new ArrayList<>();
                for (MasaIcerik masaIcerik : masaIcerikList) {
                    DtoUrun dtoUrun = new DtoUrun();
                    DtoMasaIcerik dtoMasaIcerik = new DtoMasaIcerik();
                    Urun urun = masaIcerik.getUrun();
                    BeanUtils.copyProperties(urun, dtoUrun);
                    BeanUtils.copyProperties(masaIcerik, dtoMasaIcerik);
                    dtoMasaIcerik.setUrun(dtoUrun);
                    dtoMasaIcerikList.add(dtoMasaIcerik);
                }
                BeanUtils.copyProperties(masa, dtoMasa);
                dtoMasa.setMasaIcerikList(dtoMasaIcerikList);
                dtoMasaList.add(dtoMasa);
            }
            return dtoMasaList;
        }
        return null;
    }

    @Override
    public DtoMasa getMasa(String id) {
        Optional<Masa> optionalmasa = masaRepository.findById(id);
        if (optionalmasa.isPresent()) {
            Masa masa = optionalmasa.get();
            List<MasaIcerik> masaIcerikList = masa.getMasaIcerikList();
            List<DtoMasaIcerik> dtoMasaIcerikList = new ArrayList<>();
            for (MasaIcerik masaIcerik : masaIcerikList) {
                DtoUrun dtoUrun = new DtoUrun();
                DtoMasaIcerik dtoMasaIcerik = new DtoMasaIcerik();
                Urun urun = masaIcerik.getUrun();
                BeanUtils.copyProperties(urun, dtoUrun);
                BeanUtils.copyProperties(masaIcerik, dtoMasaIcerik);
                dtoMasaIcerik.setUrun(dtoUrun);
                dtoMasaIcerikList.add(dtoMasaIcerik);
            }
            DtoMasa dtoMasa = new DtoMasa();
            BeanUtils.copyProperties(masa, dtoMasa);
            dtoMasa.setMasaIcerikList(dtoMasaIcerikList);
            return dtoMasa;

        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile bir masa bulunmamaktadır!"));
        }
    }

    @Override
    public DtoMasa postMasa(DtoMasaIU dtoMasaIU) {
        // Alan'ı alıp doğrula
        Optional<Alan> optionalAlan = alanRepository.findById(dtoMasaIU.getAlanId());
        if (!optionalAlan.isPresent()) {
            throw new RuntimeException("Alan bulunamadı.");
        }

        // Masa oluştur
        Masa masa = new Masa();
        masa.setAlanId(dtoMasaIU.getAlanId());
        masa.setMasaAdi(dtoMasaIU.getMasaAdi());
        masa.setToplamTutar(BigDecimal.ZERO);
        masa.setOlusturulmaTarihi(new Date());
        masa.setSonGuncellemeTarihi(new Date());
        masa.setMasaDurumu(false);
        masa.setMasaIcerikList(new ArrayList<>());

        // Veritabanına kaydet
        Masa dbMasa = masaRepository.save(masa);

        // DTO'ya dönüştür
        DtoMasa dtoMasa = new DtoMasa();
        BeanUtils.copyProperties(dbMasa, dtoMasa);
        return dtoMasa;
    }

    @Override
    public DtoMasa putMasaGuncelle(String masaId, DtoMasaGuncelle dtoMasaGuncelle) {
        Optional<Masa> optionalmasa = masaRepository.findById(masaId);
        Optional<Alan> optionalalan = alanRepository.findById(dtoMasaGuncelle.getAlanId());
        DtoMasa dtoMasa = new DtoMasa();
        if (!optionalmasa.isEmpty() && !optionalalan.isEmpty()) {
            Masa dbMasa = optionalmasa.get();
            dbMasa.setAlanId(dtoMasaGuncelle.getAlanId());
            dbMasa.setMasaAdi(dtoMasaGuncelle.getMasaIsmi());
            dbMasa.setSonGuncellemeTarihi(new Date());

            Masa updatedAlan = masaRepository.save(dbMasa);

            BeanUtils.copyProperties(updatedAlan, dtoMasa);
            return dtoMasa;
        }

        return null;
    }

    @Override
    public DtoMasa postMasaUrunEkle(String masaId, DtoMasaIcerikIU dtoMasaUrunEkle) {
        Optional<Masa> optionalMasa = masaRepository.findById(masaId);
        DtoMasa dtoMasa = new DtoMasa();

        if (optionalMasa.isPresent()) {
            Masa dbMasa = optionalMasa.get();
            Optional<Urun> optionalUrun = urunRepository.findById(dtoMasaUrunEkle.getUrun().getId());
            
            if(dbMasa.isMasaDurumu()) {
                if (optionalUrun.isPresent()) {
                    Urun urun = optionalUrun.get();
        
                    MasaIcerik masaIcerik = new MasaIcerik();
                    masaIcerik.setUrun(urun);
                    masaIcerik.setUrunAdet(dtoMasaUrunEkle.getUrunAdet());
                    masaIcerik.setUrunEklenmeTarihi(new Date());
                    masaIcerik.setOdenmeDurumu(false);
        
                    // Eğer masa içeriği listesi boşsa, başlatıyoruz
                    if (dbMasa.getMasaIcerikList().isEmpty()) {
                        dbMasa.setMasaIcerikList(new ArrayList<>());
                    }

                    // Masa içeriği listesine yeni ürünü ekliyoruz
                    dbMasa.getMasaIcerikList().add(masaIcerik);

                    // Eklenen ürünün fiyatını alıyoruz
                    BigDecimal urunFiyati = urun.getFiyat();
                    Long urunAdeti = masaIcerik.getUrunAdet();
                    
                    // Toplam tutara ekliyoruz (adet * fiyat)
                    BigDecimal toplamFiyat = urunFiyati.multiply(BigDecimal.valueOf(urunAdeti));
                    if (dbMasa.getToplamTutar() == null) {
                        dbMasa.setToplamTutar(BigDecimal.ZERO);
                    }
                    dbMasa.setToplamTutar(dbMasa.getToplamTutar().add(toplamFiyat));

                    // Masayı güncelliyoruz
                    Masa masaGuncellenmis = masaRepository.save(dbMasa);
                    BeanUtils.copyProperties(masaGuncellenmis, dtoMasa);

                    // Masa içeriği listesini DTO'ya dönüştürüp ekliyoruz
                    List<DtoMasaIcerik> dtoMasaIcerikList = new ArrayList<>();
                    for (MasaIcerik masaIcerikDb : masaGuncellenmis.getMasaIcerikList()) {
                        DtoMasaIcerik dtoMasaIcerik = new DtoMasaIcerik();
                        BeanUtils.copyProperties(masaIcerikDb, dtoMasaIcerik);

                        // DtoUrun nesnesini oluştur ve ata
                        DtoUrun dtoUrun = new DtoUrun();
                        if (masaIcerikDb.getUrun() != null) {
                            BeanUtils.copyProperties(masaIcerikDb.getUrun(), dtoUrun);
                        }
                        dtoMasaIcerik.setUrun(dtoUrun); // DtoMasaIcerik'e DtoUrun'u ekle

                        dtoMasaIcerikList.add(dtoMasaIcerik);
                    }
                    dtoMasa.setMasaIcerikList(dtoMasaIcerikList);

                    return dtoMasa;
                }
                return null;
            }
            else {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Önce masayı açmalısınız!"));
            }

        } else {
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile bir masa bulunmamaktadır!"));
        }
    }


    @Override
    public DtoMasa putMasaUrunOde(String masaId, List<DtoMasaIcerikOde> dtoMasaUrunSilList) {
        Optional<Masa> optionalMasa = masaRepository.findById(masaId);
        DtoMasa dtoMasa = new DtoMasa();

        if (optionalMasa.isPresent()) {
            Masa masa = optionalMasa.get();
            List<MasaIcerik> masaIcerikList = masa.getMasaIcerikList();

            // Ödenen ürünlere göre masa fiyatını güncelleme
            BigDecimal toplamOdenenFiyat = BigDecimal.ZERO;

            // Her ürün için işlem yap
            for (DtoMasaIcerikOde dtoMasaUrunSil : dtoMasaUrunSilList) {
                MasaIcerik mevcutIcerik = masaIcerikList.stream()
                    .filter(icerik -> icerik.getId().equals(dtoMasaUrunSil.getId()) && !icerik.isOdenmeDurumu())
                    .findFirst()
                    .orElse(null);

                if (mevcutIcerik != null) {
                    Long mevcutAdet = mevcutIcerik.getUrunAdet();
                    Long silinecekAdet = dtoMasaUrunSil.getUrunAdet();

                    // Ödenen ürünün fiyatını hesapla
                    BigDecimal urunFiyati = mevcutIcerik.getUrun().getFiyat(); // Ürünün fiyatı
                    BigDecimal toplamFiyat = urunFiyati.multiply(BigDecimal.valueOf(silinecekAdet));

                    if (mevcutAdet.equals(silinecekAdet)) {
                        mevcutIcerik.setOdenmeDurumu(true);
                        mevcutIcerik.setUrunKaldirilmaTarihi(new Date());
                    } else if (mevcutAdet > silinecekAdet) {
                        MasaIcerik ayrilmisMasaIcerik = new MasaIcerik();
                        mevcutIcerik.setUrunAdet(mevcutAdet - silinecekAdet);
                        BeanUtils.copyProperties(mevcutIcerik, ayrilmisMasaIcerik);
                        ayrilmisMasaIcerik.setUrunAdet(silinecekAdet);
                        ayrilmisMasaIcerik.setOdenmeDurumu(true);
                        ayrilmisMasaIcerik.setUrunKaldirilmaTarihi(new Date());
                        masaIcerikList.add(ayrilmisMasaIcerik);
                    } else {
                        throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Ödenecek adet mevcut adetten fazla olamaz!"));
                    }

                    // Ödenen toplam fiyatı güncellemeye ekliyoruz
                    toplamOdenenFiyat = toplamOdenenFiyat.add(toplamFiyat);
                }
            }

            // Masa fiyatını güncelle
            if (masa.getToplamTutar() == null) {
                masa.setToplamTutar(BigDecimal.ZERO);
            }

            // Ödenen tutarı çıkarıyoruz
            masa.setToplamTutar(masa.getToplamTutar().subtract(toplamOdenenFiyat));

            // Masayı güncelliyoruz
            masa.setMasaIcerikList(masaIcerikList);
            Masa dbMasa = masaRepository.save(masa);

            masaIcerikList = dbMasa.getMasaIcerikList();
            List<DtoMasaIcerik> dtoMasaIcerikList = new ArrayList<>();
            for (MasaIcerik masaIcerik : masaIcerikList) {
                DtoUrun dtoUrun = new DtoUrun();
                DtoMasaIcerik dtoMasaIcerik = new DtoMasaIcerik();
                Urun urun = masaIcerik.getUrun();
                BeanUtils.copyProperties(urun, dtoUrun);
                BeanUtils.copyProperties(masaIcerik, dtoMasaIcerik);
                dtoMasaIcerik.setUrun(dtoUrun);
                dtoMasaIcerikList.add(dtoMasaIcerik);
            }

            BeanUtils.copyProperties(masa, dtoMasa);
            dtoMasa.setMasaIcerikList(dtoMasaIcerikList);
            return dtoMasa;
        }
        else {
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile bir masa bulunmamaktadır!"));
        }
    }


    @Override
    public DtoMasa putMasaBosalt(String masaId) {
        Optional<Masa> optional=masaRepository.findById(masaId);
        if(optional.isPresent()){
            DtoMasa dtoMasa=new DtoMasa();
            Masa masa=optional.get();
            GecmisMasa gecmisMasa=new GecmisMasa();
            List<MasaIcerik> masaIcerikList=masa.getMasaIcerikList();
            // Ödenmemiş ürün kontrolü
            boolean odemesiYapilmamisUrunVarMi = masaIcerikList.stream()
            .anyMatch(masaIcerik -> !masaIcerik.isOdenmeDurumu());

            if (odemesiYapilmamisUrunVarMi) {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Ödenmemiş ürünler bulunmaktadır!"));
            }
            List<GecmisMasaIcerik> gecmisMasaIcerikList=new ArrayList<>();
            BigDecimal toplamTutar = BigDecimal.ZERO;
            for (MasaIcerik masaIcerik : masaIcerikList) {
                GecmisMasaIcerik gecmisMasaIcerik=new GecmisMasaIcerik();
                gecmisMasaIcerik.setOdenmeDurumu(masaIcerik.isOdenmeDurumu());
                gecmisMasaIcerik.setUrun(masaIcerik.getUrun());
                gecmisMasaIcerik.setUrunAdet(masaIcerik.getUrunAdet());
                gecmisMasaIcerik.setUrunEklenmeTarihi(masaIcerik.getUrunEklenmeTarihi());
                gecmisMasaIcerik.setUrunKaldirilmaTarihi(masaIcerik.getUrunKaldirilmaTarihi());
                gecmisMasaIcerikList.add(gecmisMasaIcerik);
                BigDecimal urunFiyat = new BigDecimal(masaIcerik.getUrun().getFiyat().toString());
                BigDecimal urunAdet = new BigDecimal(masaIcerik.getUrunAdet().toString());
                toplamTutar = toplamTutar.add(urunFiyat.multiply(urunAdet));
            }
            gecmisMasa.setGecmisMasaIcerikList(gecmisMasaIcerikList);
            gecmisMasa.setMasaId(masaId);
            gecmisMasa.setMasaMusteriGelmeTarihi(masa.getMasaMusteriGelmeTarihi());
            gecmisMasa.setMasaMusteriGitmeTarihi(new Date());
            gecmisMasa.setToplamTutar(toplamTutar);
            gecmisMasaRepository.save(gecmisMasa);

            masa.getMasaIcerikList().clear();
            masa.setMasaDurumu(false);
            Masa dbMasa=masaRepository.save(masa);
            BeanUtils.copyProperties(dbMasa, dtoMasa);
            dtoMasa.setMasaIcerikList(new ArrayList<>());
            return dtoMasa;
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile bir masa bulunmamaktadır!"));
        }
    }

    @Override
    public DtoMasa putMasaDoldur(String masaId) {
        Optional<Masa> optional=masaRepository.findById(masaId);
        if(optional.isPresent()){
            DtoMasa dtoMasa=new DtoMasa();
            Masa masa=optional.get();
            masa.setMasaDurumu(true);
            masa.setMasaMusteriGelmeTarihi(new Date());
            masa.setToplamTutar(BigDecimal.ZERO);
            Masa dbMasa=masaRepository.save(masa);
            BeanUtils.copyProperties(dbMasa, dtoMasa);
            dtoMasa.setMasaIcerikList(new ArrayList<>());
            return dtoMasa;
        }else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile bir masa bulunmamaktadır!"));
        }

    }


}
