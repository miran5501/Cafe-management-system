package com.kafe.kafe_yonetim_sistemi.dto;

import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoGecmisIslemlerMasa {

    private String id;

    private Date musteriGelmeTarihi;

    private Date musteriGitmeTarihi;

    private BigDecimal tutar;

    private DtoMasa masa;
}
