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

import com.kafe.kafe_yonetim_sistemi.controller.IKategoriController;
import com.kafe.kafe_yonetim_sistemi.dto.DtoKategori;
import com.kafe.kafe_yonetim_sistemi.dto.DtoKategoriIU;
import com.kafe.kafe_yonetim_sistemi.service.IKategoriService;

@RestController
@RequestMapping("api/kategori")
public class KategoriControllerImpl implements IKategoriController{

    @Autowired
    private IKategoriService kategoriService;

    @GetMapping(path="/getir")
    @Override
    public List<DtoKategori> getTumKategoriler() {
        return kategoriService.getTumKategoriler();
    }

    @PostMapping(path="/kaydet")
    @Override
    public DtoKategori postKategoriKaydet(@RequestBody DtoKategoriIU dtoKategoriIU) {
        return kategoriService.postKategoriKaydet(dtoKategoriIU);
    }

    @PutMapping(path="/guncelle/{id}")
    @Override
    public DtoKategori putKategoriGuncelle(@RequestBody DtoKategoriIU dtoKategoriIU,@PathVariable(name="id") String id) {
        return kategoriService.putKategoriGuncelle(dtoKategoriIU, id);
    }

}
