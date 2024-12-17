package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoGecmisMasa;
import com.kafe.kafe_yonetim_sistemi.dto.DtoGecmisMasaIcerik;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrun;
import com.kafe.kafe_yonetim_sistemi.entities.GecmisMasa;
import com.kafe.kafe_yonetim_sistemi.entities.GecmisMasaIcerik;
import com.kafe.kafe_yonetim_sistemi.entities.Urun;
import com.kafe.kafe_yonetim_sistemi.exception.BaseException;
import com.kafe.kafe_yonetim_sistemi.exception.ErrorMessage;
import com.kafe.kafe_yonetim_sistemi.exception.MessageType;
import com.kafe.kafe_yonetim_sistemi.repository.GecmisMasaRepository;
import com.kafe.kafe_yonetim_sistemi.service.IGecmisMasaService;

@Service
public class GecmisMasaServiceImpl implements IGecmisMasaService{

    @Autowired
    private GecmisMasaRepository gecmisMasaRepository;

    @Override
    public List<DtoGecmisMasa> getAllGecmisMasa() {
        List<DtoGecmisMasa> dtoGecmisMasaList = new ArrayList<>();
        List<GecmisMasa> gecmisMasaList = gecmisMasaRepository.findAll();
        if (gecmisMasaList != null && !gecmisMasaList.isEmpty()) {
            for (GecmisMasa gecmisMasa : gecmisMasaList) {
                DtoGecmisMasa dtoGecmisMasa = new DtoGecmisMasa();
                List<GecmisMasaIcerik> gecmisMasaIcerikList = gecmisMasa.getGecmisMasaIcerikList();
                List<DtoGecmisMasaIcerik> dtoGecmisMasaIcerikList = new ArrayList<>();
                for (GecmisMasaIcerik gecmisMasaIcerik : gecmisMasaIcerikList) {
                    DtoUrun dtoUrun = new DtoUrun();
                    DtoGecmisMasaIcerik dtoGecmisMasaIcerik = new DtoGecmisMasaIcerik();
                    Urun urun = gecmisMasaIcerik.getUrun();
                    BeanUtils.copyProperties(urun, dtoUrun);
                    BeanUtils.copyProperties(gecmisMasaIcerik, dtoGecmisMasaIcerik);
                    dtoGecmisMasaIcerik.setUrun(dtoUrun);
                    dtoGecmisMasaIcerikList.add(dtoGecmisMasaIcerik);
                }
                BeanUtils.copyProperties(gecmisMasa, dtoGecmisMasa);
                dtoGecmisMasa.setGecmisMasaIcerikList(dtoGecmisMasaIcerikList);
                dtoGecmisMasaList.add(dtoGecmisMasa);
            }
            return dtoGecmisMasaList;
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Geçmiş masa bulunmamaktadır!"));
        }
    }

    @Override
    public DtoGecmisMasa getGecmisMasa(String id) {
        Optional<GecmisMasa> optionalGecmisMasa = gecmisMasaRepository.findById(id);
        if (optionalGecmisMasa.isPresent()) {
            GecmisMasa gecmisMasa = optionalGecmisMasa.get();
            List<GecmisMasaIcerik> gecmisMasaIcerikList = gecmisMasa.getGecmisMasaIcerikList();
            List<DtoGecmisMasaIcerik> dtoGecmisMasaIcerikList = new ArrayList<>();
            for (GecmisMasaIcerik gecmisMasaIcerik : gecmisMasaIcerikList) {
                DtoUrun dtoUrun = new DtoUrun();
                DtoGecmisMasaIcerik dtoGecmisMasaIcerik = new DtoGecmisMasaIcerik();
                Urun urun = gecmisMasaIcerik.getUrun();
                BeanUtils.copyProperties(urun, dtoUrun);
                BeanUtils.copyProperties(gecmisMasaIcerik, dtoGecmisMasaIcerik);
                dtoGecmisMasaIcerik.setUrun(dtoUrun);
                dtoGecmisMasaIcerikList.add(dtoGecmisMasaIcerik);
            }
            DtoGecmisMasa dtoGecmisMasa = new DtoGecmisMasa();
            BeanUtils.copyProperties(gecmisMasa, dtoGecmisMasa);
            dtoGecmisMasa.setGecmisMasaIcerikList(dtoGecmisMasaIcerikList);
            return dtoGecmisMasa;

        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile bir masa bulunmamaktadır!"));
        }
    }

}
