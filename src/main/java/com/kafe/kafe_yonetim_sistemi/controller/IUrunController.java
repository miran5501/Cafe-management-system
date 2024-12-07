package com.kafe.kafe_yonetim_sistemi.controller;

import java.util.List;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUrun;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUrunIU;

public interface IUrunController {

    public List<DtoUrun> getTumUrunler();

    public List<DtoUrun> getUrunlerKategoriyeGore(String kategoriId);

    public DtoUrun postUrunKaydet(DtoUrunIU dtoUrunIU);
}
