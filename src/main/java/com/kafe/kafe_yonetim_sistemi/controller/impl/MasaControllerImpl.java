package com.kafe.kafe_yonetim_sistemi.controller.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIcerikOde;
import com.kafe.kafe_yonetim_sistemi.service.impl.MasaServiceImpl;

@CrossOrigin
@RestController
@RequestMapping("/api/masa")
public class MasaControllerImpl implements IMasaController {

    @Autowired
    private MasaServiceImpl masaService;

    @GetMapping(path = "/getir")
    @Override
    public List<DtoMasa> getAllMasa() {
        return masaService.getAllMasa();
    }

    @GetMapping(path = "/getir/{id}")
    @Override
    public DtoMasa getMasa(@PathVariable(name = "id") String id) {
        return masaService.getMasa(id);
    }

    @PostMapping(path = "/kaydet")
    @Override
    public DtoMasa postMasa(@RequestBody DtoMasaIU dtoMasaIU) {
        return masaService.postMasa(dtoMasaIU);
    }

    @PutMapping(path = "/guncelle/{id}")
    @Override
    public DtoMasa putMasaGuncelle(@PathVariable(name = "id") String masaId, @RequestBody DtoMasaGuncelle dtoMasaGuncelle) {
        return masaService.putMasaGuncelle(masaId, dtoMasaGuncelle);
    }

    @PostMapping(path = "/urun-ekle/{masaid}")
    @Override
    public DtoMasa postMasaUrunEkle(@PathVariable(name = "masaid") String masaId, @RequestBody DtoMasaIcerikIU dtoMasaUrunEkle) {
        return masaService.postMasaUrunEkle(masaId, dtoMasaUrunEkle);
    }

    @PutMapping(path = "/urun-ode/{masaid}")
    @Override
    public DtoMasa putMasaUrunOde(@PathVariable(name = "masaid") String masaId, @RequestBody List<DtoMasaIcerikOde> dtoMasaUrunSilList) {
        return masaService.putMasaUrunOde(masaId, dtoMasaUrunSilList);
    }

    @PutMapping(path="/bosalt/{id}")
    @Override
    public DtoMasa putMasaBosalt(@PathVariable(name="id") String masaId) {
        return masaService.putMasaBosalt(masaId);
    }

    @PutMapping(path="/doldur/{id}")
    @Override
    public DtoMasa putMasaDoldur(@PathVariable(name="id") String masaId) {
        return masaService.putMasaDoldur(masaId);
    }

    

}
