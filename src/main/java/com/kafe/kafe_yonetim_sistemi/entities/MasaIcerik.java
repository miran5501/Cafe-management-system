package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.DBRef;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class MasaIcerik {

    @DBRef
    private Urun urun;
    
    private Date urunEklenmeTarihi;

    private Long urunAdet;

    private Date urunKaldirilmaTarihi;
}
