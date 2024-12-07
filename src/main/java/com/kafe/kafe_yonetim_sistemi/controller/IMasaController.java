package com.kafe.kafe_yonetim_sistemi.controller;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoMasa;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaGuncelle;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoMasaIcerikIU;

public interface IMasaController {

    public List<DtoMasa> getAllMasa();

    public DtoMasa postMasa(DtoMasaIU dtoMasaIU);

    public DtoMasa getMasa(String id);

    public DtoMasa putMasaGuncelle(String masaId, DtoMasaGuncelle dtoMasaGuncelle);

    public DtoMasa postMasaUrunEkle(String masaId, DtoMasaIcerikIU dtoMasaUrunEkle);

    public DtoMasa putMasaUrunSil(String masaId, List<DtoMasaIcerikIU> dtoMasaUrunSil);
}
