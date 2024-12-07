package com.kafe.kafe_yonetim_sistemi.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoUrunIU {

    private String urunAdi;

    private BigDecimal fiyat;

    private Long stok;

    private String kategoriId;
}
