package com.kafe.kafe_yonetim_sistemi.controller;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoKategori;
import com.kafe.kafe_yonetim_sistemi.dto.DtoKategoriIU;

public interface IKategoriController {

    public List<DtoKategori> getTumKategoriler();

    public DtoKategori postKategoriKaydet(DtoKategoriIU dtoKategoriIU);

    public DtoKategori putKategoriGuncelle(DtoKategoriIU dtoKategoriIU, String id);
}
