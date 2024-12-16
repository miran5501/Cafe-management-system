package com.kafe.kafe_yonetim_sistemi.controller;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoGecmisMasa;

public interface IGecmisMasaController {

    public List<DtoGecmisMasa> getAllGecmisMasa();

    public DtoGecmisMasa getGecmisMasa(String id);

}
