package com.kafe.kafe_yonetim_sistemi.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoMasaIcerik {

    private DtoUrun urun;

    private Long urunAdet;

    private Date urunEklenmeTarihi;

    private Date urunKaldirilmaTarihi;
}
