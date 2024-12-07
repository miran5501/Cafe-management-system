package com.kafe.kafe_yonetim_sistemi.service.impl;

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
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrun;
import com.kafe.kafe_yonetim_sistemi.entities.Alan;
import com.kafe.kafe_yonetim_sistemi.entities.Masa;
import com.kafe.kafe_yonetim_sistemi.entities.MasaIcerik;
import com.kafe.kafe_yonetim_sistemi.entities.Urun;
import com.kafe.kafe_yonetim_sistemi.repository.AlanRepository;
import com.kafe.kafe_yonetim_sistemi.repository.MasaRepository;
import com.kafe.kafe_yonetim_sistemi.repository.UrunRepository;
import com.kafe.kafe_yonetim_sistemi.service.IMasaService;

@Service
public class MasaServiceImpl implements IMasaService{

    @Autowired
    private MasaRepository masaRepository;

    @Autowired
    private AlanRepository alanRepository;

    @Autowired
    private UrunRepository urunRepository;

    @Override
    public List<DtoMasa> getAllMasa() {
        List<DtoMasa> dtoMasaList=new ArrayList<>();
        List<Masa> masaList = masaRepository.findAll();
        if(masaList!=null && !masaList.isEmpty()){
            for (Masa masa : masaList) {
                DtoMasa dtoMasa= new DtoMasa();
                BeanUtils.copyProperties(masa, dtoMasa);
                dtoMasaList.add(dtoMasa);
            }
            return dtoMasaList;
        }
        return null;
    }

    @Override
    public DtoMasa getMasa(String id) {
        Optional<Masa> optionalmasa=masaRepository.findById(id);
        if(optionalmasa.isPresent()){
            Masa masa=optionalmasa.get();
            List<MasaIcerik> masaIcerikList= masa.getMasaIcerikList();
            List<DtoMasaIcerik> dtoMasaIcerikList = new ArrayList<>();
            for (MasaIcerik masaIcerik : masaIcerikList) {
                DtoUrun dtoUrun=new DtoUrun();
                DtoMasaIcerik dtoMasaIcerik=new DtoMasaIcerik();
                Urun urun=masaIcerik.getUrun();
                BeanUtils.copyProperties(urun, dtoUrun);
                BeanUtils.copyProperties(masaIcerik, dtoMasaIcerik);
                dtoMasaIcerik.setUrun(dtoUrun);
                dtoMasaIcerikList.add(dtoMasaIcerik);
            }
            DtoMasa dtoMasa=new DtoMasa();
            BeanUtils.copyProperties(masa, dtoMasa);
            dtoMasa.setMasaIcerikList(dtoMasaIcerikList);
            return dtoMasa;

        }
        return null;
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
        Optional<Alan> optionalalan= alanRepository.findById(dtoMasaGuncelle.getAlanId());
        DtoMasa dtoMasa = new DtoMasa();
        if(!optionalmasa.isEmpty() && !optionalalan.isEmpty()){
            Masa dbMasa=optionalmasa.get();
            dbMasa.setAlanId(dtoMasaGuncelle.getAlanId());
            dbMasa.setMasaAdi(dtoMasaGuncelle.getMasaIsmi());
            dbMasa.setSonGuncellemeTarihi(new Date());

            Masa updatedAlan=masaRepository.save(dbMasa);

            BeanUtils.copyProperties(updatedAlan, dtoMasa);
            return dtoMasa;
        }

        return null;
    }

    @Override
    public DtoMasa postMasaUrunEkle(String masaId, DtoMasaIcerikIU dtoMasaUrunEkle) {
        Optional<Masa> optionalMasa=masaRepository.findById(masaId);
        DtoMasa dtoMasa=new DtoMasa();

        if(optionalMasa.isPresent()){
            Masa dbMasa=optionalMasa.get();
            Optional<Urun> optionalUrun=urunRepository.findById(dtoMasaUrunEkle.getUrun().getId());

            if(optionalUrun.isPresent()){
                Urun urun=optionalUrun.get();

                MasaIcerik masaIcerik=new MasaIcerik();
                masaIcerik.setUrun(urun);
                masaIcerik.setUrunAdet(dtoMasaUrunEkle.getUrunAdet());
                masaIcerik.setUrunEklenmeTarihi(new Date());

                if(dbMasa.getMasaIcerikList().isEmpty()){
                    dbMasa.setMasaIcerikList(new ArrayList<>());
                }
                dbMasa.getMasaIcerikList().add(masaIcerik);
                Masa masaGuncellenmis= masaRepository.save(dbMasa);
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
        }
        return null;
    }

    @Override
    public DtoMasa putMasaUrunSil(String masaId, List<DtoMasaIcerikIU> dtoMasaUrunSil) {
        Optional<Masa> optionalMasa=masaRepository.findById(masaId);
        if(optionalMasa.isPresent()){
            // Masa masa=optionalMasa.get();
            // for (DtoMasaIcerikIU dtoMasaIcerikIU : dtoMasaUrunSil) {
                

                
            // }

        }
        
        
        return null;
    }

    

}