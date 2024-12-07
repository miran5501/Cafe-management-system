package com.kafe.kafe_yonetim_sistemi.dto;

import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoGunluk {

    private String id;

    private Date tarih;

    private BigDecimal toplamTutar;
}
