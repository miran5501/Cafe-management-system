package com.kafe.kafe_yonetim_sistemi.dto;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoGecmisMasa {

    private String id;

    private String masaId;

    private BigDecimal toplamTutar;

    private Date masaMusteriGelmeTarihi;

    private Date masaMusteriGitmeTarihi;

    private List<DtoGecmisMasaIcerik> gecmisMasaIcerikList;
}
