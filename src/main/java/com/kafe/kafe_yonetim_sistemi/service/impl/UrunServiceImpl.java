package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUrun;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrunIU;
import com.kafe.kafe_yonetim_sistemi.entities.Kategori;
import com.kafe.kafe_yonetim_sistemi.entities.Urun;
import com.kafe.kafe_yonetim_sistemi.exception.BaseException;
import com.kafe.kafe_yonetim_sistemi.exception.ErrorMessage;
import com.kafe.kafe_yonetim_sistemi.exception.MessageType;
import com.kafe.kafe_yonetim_sistemi.repository.KategoriRepository;
import com.kafe.kafe_yonetim_sistemi.repository.UrunRepository;
import com.kafe.kafe_yonetim_sistemi.service.IUrunService;

@Service
public class UrunServiceImpl implements IUrunService{

    @Autowired
    private UrunRepository urunRepository;

    @Autowired
    private KategoriRepository kategoriRepository;

    @Override
    public List<DtoUrun> getTumUrunler() {
        List<DtoUrun> dtoUrunList=new ArrayList<>();
        List<Urun> urunList=urunRepository.findAll();
        if(!urunList.isEmpty()){
            for (Urun urun : urunList) {
                DtoUrun dtoUrun=new DtoUrun();
                BeanUtils.copyProperties(urun, dtoUrun);
                dtoUrunList.add(dtoUrun);
            }
            return dtoUrunList;
        }
        throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Ürün bulunmamaktadır!"));
    }

    @Override
    public List<DtoUrun> getUrunlerKategoriyeGore(String kategoriId) {
        Optional<Kategori> optional=kategoriRepository.findById(kategoriId);
        if(optional.isPresent()){
            List<DtoUrun> dtoUrunList=new ArrayList<>();
            List<Urun> urunList=urunRepository.findByKategoriId(kategoriId);
            if(!urunList.isEmpty()){
                for (Urun urun : urunList) {
                    DtoUrun dtoUrun=new DtoUrun();
                    BeanUtils.copyProperties(urun, dtoUrun);
                    dtoUrunList.add(dtoUrun);
                }
                return dtoUrunList;
            }
            else{
                throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu kategoride ürün bulunmamaktadır!"));
            }
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile kategori bulunmamaktadır!"));
        }
        
    }

    @Override
    public DtoUrun postUrunKaydet(DtoUrunIU dtoUrunIU) {
        Urun urun = new Urun();
        DtoUrun dtoUrun= new DtoUrun();

        BeanUtils.copyProperties(dtoUrunIU, urun);
        urun.setOlusturulmaTarihi(new Date());
        urun.setSonGuncellemeTarihi(new Date());
        Urun dbUrun=urunRepository.save(urun);
        
        BeanUtils.copyProperties(dbUrun, dtoUrun);
        return dtoUrun;
    }

    @Override
    public DtoUrun getUrun(String id) {
        Optional<Urun> optional=urunRepository.findById(id);
        if(optional.isPresent()){
            Urun urun=optional.get();
            DtoUrun dtoUrun=new DtoUrun();
            BeanUtils.copyProperties(urun, dtoUrun);
            return dtoUrun;
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile ürün bulunmamaktadır!"));
        }
    }

    @Override
    public DtoUrun putUrunGuncelle(DtoUrunIU urunIU, String id) {
        Optional<Urun> optional=urunRepository.findById(id);
        if(optional.isPresent()){
            Urun urun=optional.get();
            if (urunIU.getUrunAdi() == null || urunIU.getUrunAdi().isEmpty()) {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Ürün adı boş olamaz!"));
            }
            if (urunIU.getFiyat() == null) {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Fiyat boş olamaz!"));
            }
            if (urunIU.getStok() == null) {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Stok boş olamaz!"));
            }
            if (urunIU.getResim() == null || urunIU.getResim().isEmpty()) {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Resim boş olamaz!"));
            }
            if (urunIU.getKategoriId() == null || urunIU.getKategoriId().isEmpty()) {
                throw new BaseException(new ErrorMessage(MessageType.ISLEM_KONTROLU, "Kategori boş olamaz!"));
            }
            urun.setUrunAdi(urunIU.getUrunAdi());
            urun.setFiyat(urunIU.getFiyat());
            urun.setResim(urunIU.getResim());
            urun.setKategoriId(urunIU.getKategoriId());
            urun.setStok(urunIU.getStok());
            DtoUrun dtoUrun=new DtoUrun();
    
            Urun updatedUrun = urunRepository.save(urun);
            BeanUtils.copyProperties(updatedUrun, dtoUrun);
    
            return dtoUrun;
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile ürün bulunmamaktadır!"));
        }


        
    }


}
