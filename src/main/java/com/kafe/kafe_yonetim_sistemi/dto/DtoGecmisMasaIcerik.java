package com.kafe.kafe_yonetim_sistemi.dto;

import java.util.Date;

import com.kafe.kafe_yonetim_sistemi.entities.Urun;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoGecmisMasaIcerik {

    private String id;

    private Urun urun;

    private Date urunEklenmeTarihi;

    private Long urunAdet;

    private Date urunKaldirilmaTarihi;

    private boolean odenmeDurumu;
}
