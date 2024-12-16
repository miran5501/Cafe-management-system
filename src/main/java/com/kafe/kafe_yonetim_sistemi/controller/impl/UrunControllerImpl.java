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

import com.kafe.kafe_yonetim_sistemi.controller.IUrunController;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrun;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrunIU;
import com.kafe.kafe_yonetim_sistemi.service.IUrunService;

@CrossOrigin
@RestController
@RequestMapping("/api/urun")
public class UrunControllerImpl implements IUrunController{

    @Autowired
    private IUrunService urunService;


    @GetMapping(path="/getir")
    @Override
    public List<DtoUrun> getTumUrunler() {
        return urunService.getTumUrunler();
    }


    @GetMapping(path="/getir-kategori/{id}")
    @Override
    public List<DtoUrun> getUrunlerKategoriyeGore(@PathVariable(name="id") String kategoriId) {
        return urunService.getUrunlerKategoriyeGore(kategoriId);
    }


    @PostMapping(path="/kaydet")
    @Override
    public DtoUrun postUrunKaydet(@RequestBody DtoUrunIU dtoUrunIU) {
        return urunService.postUrunKaydet(dtoUrunIU);
    }


    @GetMapping(path="/getir/{id}")
    @Override
    public DtoUrun getUrun(@PathVariable(name="id") String id) {
        return urunService.getUrun(id);
    }


    @PutMapping(path="/guncelle/{id}")
    @Override
    public DtoUrun putUrunGuncelle(@RequestBody DtoUrunIU urunIU,@PathVariable(name="id") String id) {
        return urunService.putUrunGuncelle(urunIU, id);
    }

}
