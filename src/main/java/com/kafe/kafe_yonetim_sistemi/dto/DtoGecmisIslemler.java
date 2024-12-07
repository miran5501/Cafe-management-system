package com.kafe.kafe_yonetim_sistemi.dto;

import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoGecmisIslemler {

    private String id;

    private Long adet;

    private BigDecimal tutar;

    private Date urunEklenmeTarihi;

    private DtoUrun urun;

    private DtoGecmisIslemlerMasa gecmisIslemlerMasa;
}
