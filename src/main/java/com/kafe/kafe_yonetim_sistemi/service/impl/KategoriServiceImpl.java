package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoKategori;
import com.kafe.kafe_yonetim_sistemi.dto.DtoKategoriIU;
import com.kafe.kafe_yonetim_sistemi.entities.Kategori;
import com.kafe.kafe_yonetim_sistemi.repository.KategoriRepository;
import com.kafe.kafe_yonetim_sistemi.service.IKategoriService;

@Service
public class KategoriServiceImpl implements IKategoriService{

    @Autowired
    private KategoriRepository kategoriRepository;

    @Override
    public List<DtoKategori> getTumKategoriler() {
        List<DtoKategori> dtoKategoriList=new ArrayList<>();
        List<Kategori> kategoriList=kategoriRepository.findAll();

        if(!kategoriList.isEmpty()){
            for (Kategori kategori : kategoriList) {
                DtoKategori dtoKategori=new DtoKategori();
                BeanUtils.copyProperties(kategori, dtoKategori);
                dtoKategoriList.add(dtoKategori);
            }
            return dtoKategoriList;
        }
        return null;
    }

    @Override
    public DtoKategori postKategoriKaydet(DtoKategoriIU dtoKategoriIU) {
        Kategori kategori = new Kategori();
        DtoKategori dtoKategori=new DtoKategori();

        kategori.setKategoriIsmi(dtoKategoriIU.getKategoriIsmi());
        kategori.setOlusturulmaTarihi(new Date());
        kategori.setSonGuncellemeTarihi(new Date());
        Kategori dbKategori=kategoriRepository.save(kategori);
        BeanUtils.copyProperties(dbKategori, dtoKategori);
        return dtoKategori;
    }

    @Override
    public DtoKategori putKategoriGuncelle(DtoKategoriIU dtoKategoriIU, String id) {
        Optional<Kategori> optional=kategoriRepository.findById(id);
        if(optional.isPresent()){
            DtoKategori dtoKategori=new DtoKategori();
            Kategori kategori=optional.get();
            kategori.setKategoriIsmi(dtoKategoriIU.getKategoriIsmi());
            Kategori dbKategori=kategoriRepository.save(kategori);
            BeanUtils.copyProperties(dbKategori, dtoKategori);
            return dtoKategori;
        }
        return null;
    }

}
