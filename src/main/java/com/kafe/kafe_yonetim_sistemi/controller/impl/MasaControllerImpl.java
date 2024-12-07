package com.kafe.kafe_yonetim_sistemi.controller.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kafe.kafe_yonetim_sistemi.controller.IMasaController;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasa;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaGuncelle;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIcerikIU;
import com.kafe.kafe_yonetim_sistemi.service.impl.MasaServiceImpl;

@RestController
@RequestMapping("/api/masa")
public class MasaControllerImpl implements IMasaController{

    @Autowired
    private MasaServiceImpl masaService;

    @GetMapping(path="/getir")
    @Override
    public List<DtoMasa> getAllMasa() {
        return masaService.getAllMasa();
    }

    @GetMapping(path="/getir/{id}")
    @Override
    public DtoMasa getMasa(@PathVariable(name="id") String id) {
        return masaService.getMasa(id);
    }

    @PostMapping(path="/kaydet")
    @Override
    public DtoMasa postMasa(@RequestBody DtoMasaIU dtoMasaIU) {
        return masaService.postMasa(dtoMasaIU);
    }

    @PutMapping(path="/{id}/guncelle")
    @Override
    public DtoMasa putMasaGuncelle(@PathVariable(name = "id") String masaId, @RequestBody DtoMasaGuncelle dtoMasaGuncelle) {
        return masaService.putMasaGuncelle(masaId, dtoMasaGuncelle);
    }

    @PostMapping(path="/{masaid}/urun-ekle")
    @Override
    public DtoMasa postMasaUrunEkle(@PathVariable(name="masaid") String masaId,@RequestBody DtoMasaIcerikIU dtoMasaUrunEkle) {
        return masaService.postMasaUrunEkle(masaId, dtoMasaUrunEkle);
    }

    @PutMapping(path="/{masaid}/urun-sil")
    @Override
    public DtoMasa putMasaUrunSil(@PathVariable(name="masaid") String masaId,@RequestBody List<DtoMasaIcerikIU> dtoMasaUrunSil) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'deleteMasaUrunSil'");
    }

    



}
