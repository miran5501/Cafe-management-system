package com.kafe.kafe_yonetim_sistemi.service;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoGecmisMasa;

public interface IGecmisMasaService {

    public List<DtoGecmisMasa> getAllGecmisMasa();

    public DtoGecmisMasa getGecmisMasa(String id);
}
