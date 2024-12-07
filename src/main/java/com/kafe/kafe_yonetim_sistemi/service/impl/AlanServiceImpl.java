package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoAlan;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlanIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlanVeMasalar;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasa;
import com.kafe.kafe_yonetim_sistemi.entities.Alan;
import com.kafe.kafe_yonetim_sistemi.entities.Masa;
import com.kafe.kafe_yonetim_sistemi.exception.BaseException;
import com.kafe.kafe_yonetim_sistemi.exception.ErrorMessage;
import com.kafe.kafe_yonetim_sistemi.exception.MessageType;
import com.kafe.kafe_yonetim_sistemi.repository.AlanRepository;
import com.kafe.kafe_yonetim_sistemi.repository.MasaRepository;
import com.kafe.kafe_yonetim_sistemi.service.IAlanService;

@Service
public class AlanServiceImpl implements IAlanService{

    @Autowired
    private AlanRepository alanRepository;

    @Autowired
    private MasaRepository masaRepository;

    @Override
    public List<DtoAlan> getTumAlanlar() {
        List<DtoAlan> dtoAlanList=new ArrayList<>();
        List<Alan> alanList= alanRepository.findAll();
        
        if(alanList!=null && !alanList.isEmpty()){
            for (Alan alan : alanList) {
                DtoAlan dtoAlan = new DtoAlan();
                BeanUtils.copyProperties(alan, dtoAlan);
                dtoAlanList.add(dtoAlan);
            }
            
            return dtoAlanList;
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, null));
        }
    }

    @Override
    public DtoAlan postAlan(DtoAlanIU dtoAlanIU) {
        DtoAlan response = new DtoAlan();
        Alan alan = new Alan();

        // Kullanıcıdan alınan alanları kopyala
        BeanUtils.copyProperties(dtoAlanIU, alan);
        
        // Tarih alanlarını ayarla
        alan.setOlusturulmaTarihi(new Date());
        alan.setSonGuncellemeTarihi(new Date()); // İlk oluşturulduğunda güncelleme tarihi de aynı

        // Alan nesnesini veritabanına kaydet
        Alan dbAlan = alanRepository.save(alan);
        
        // Veritabanından dönen alanı DTO'ya kopyala
        BeanUtils.copyProperties(dbAlan, response);

        return response;
    }

    @Override
    public DtoAlan putAlanGuncelle(String alanId, String alanIsmi) {
        Optional<Alan> optional = alanRepository.findById(alanId);
        if(optional.isPresent()){
            Alan dbAlan = optional.get();
            DtoAlan dtoAlan = new DtoAlan();

            dbAlan.setAlanIsmi(alanIsmi);
            dbAlan.setSonGuncellemeTarihi(new Date());

            Alan updatedAlan = alanRepository.save(dbAlan);
            BeanUtils.copyProperties(updatedAlan, dtoAlan);
            return dtoAlan;
        }
        return null;
    }

    @Override
    public DtoAlanVeMasalar getAlanVeMasalar(String alanId) {
        Optional<Alan> optional = alanRepository.findById(alanId);
        if(optional.isPresent()){
            Alan dbAlan=optional.get();
            DtoAlan dtoAlan=new DtoAlan();
            List<Masa> masalar = masaRepository.findByAlanId(alanId);
            List<DtoMasa> dtoMasalar=new ArrayList<>();
            if(!masalar.isEmpty()){
                
                for (Masa masa : masalar) {
                    DtoMasa dtoMasa = new DtoMasa();
                    BeanUtils.copyProperties(masa, dtoMasa);
                    dtoMasalar.add(dtoMasa);
                }
            }
            BeanUtils.copyProperties(dbAlan, dtoAlan);
            DtoAlanVeMasalar dtoAlanVeMasalar = new DtoAlanVeMasalar();
            dtoAlanVeMasalar.setAlan(dtoAlan);
            dtoAlanVeMasalar.setMasalar(dtoMasalar);
            return dtoAlanVeMasalar;
        }


        return null;
    }

}
