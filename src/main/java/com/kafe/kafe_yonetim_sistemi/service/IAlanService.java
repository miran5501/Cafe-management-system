package com.kafe.kafe_yonetim_sistemi.service;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoAlan;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlanIU;
import com.kafe.kafe_yonetim_sistemi.dto.DtoAlanVeMasalar;

public interface IAlanService {

    public List<DtoAlan> getTumAlanlar();

    public DtoAlan postAlan(DtoAlanIU dtoAlanIU);

    public DtoAlanVeMasalar getAlanVeMasalar(String alanId);

    public DtoAlan putAlanGuncelle(String alanId, String alanIsmi);
}
