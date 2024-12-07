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

import com.kafe.kafe_yonetim_sistemi.controller.IAlanController;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlan;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlanIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlanVeMasalar;
import com.kafe.kafe_yonetim_sistemi.service.IAlanService;

@RestController
@RequestMapping("api/alan")
public class AlanControllerImpl implements IAlanController{

    @Autowired
    private IAlanService alanService;

    @GetMapping(path="/getir")
    @Override
    public List<DtoAlan> getTumAlanlar() {
        return alanService.getTumAlanlar();
    }

    @PostMapping(path="/kaydet")
    @Override
    public DtoAlan postAlan(@RequestBody DtoAlanIU dtoAlanIU) {
        return alanService.postAlan(dtoAlanIU);
    }

    @GetMapping(path="/{id}")
    @Override
    public DtoAlanVeMasalar getAlanVeMasalar(@PathVariable(name = "id") String alanId) {
        return alanService.getAlanVeMasalar(alanId);
    }

    @PutMapping(path="/{id}/Guncelle")
    @Override
    public DtoAlan putAlanGuncelle(@PathVariable(name = "id") String alanId, @RequestBody String alanIsmi) {
        return alanService.putAlanGuncelle(alanId, alanIsmi);
    }

    // @PutMapping(path="/{alanId}/masalar/ekle")
    // @Override
    // public DtoAlan putAlanMasaEkle(@PathVariable(name="alanId") String alanId, @RequestBody List<DtoMasa> dtoMasaList) {
    //     return alanService.putAlanMasaEkle(alanId, dtoMasaList);
    // }
}
