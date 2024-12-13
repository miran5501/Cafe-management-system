package com.kafe.kafe_yonetim_sistemi.dto;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoMasa {

    private String id;

    private String alanId;

    private String masaAdi;

    private boolean masaDurumu;

    private Date masaMusteriGelmeTarihi;

    private List<DtoMasaIcerik> masaIcerikList;
}
