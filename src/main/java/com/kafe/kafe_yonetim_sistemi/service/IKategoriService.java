package com.kafe.kafe_yonetim_sistemi.service;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoKategori;
import com.kafe.kafe_yonetim_sistemi.dto.DtoKategoriIU;

public interface IKategoriService {

    public List<DtoKategori> getTumKategoriler();

    public DtoKategori postKategoriKaydet(DtoKategoriIU dtoKategoriIU);
}
