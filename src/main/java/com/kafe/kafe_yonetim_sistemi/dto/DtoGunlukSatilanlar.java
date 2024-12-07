package com.kafe.kafe_yonetim_sistemi.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoGunlukSatilanlar {

    private String id;

    private DtoUrun urun;

    private Long adet;

    private BigDecimal toplamFiyat;

    private DtoGunluk gunluk;
}
