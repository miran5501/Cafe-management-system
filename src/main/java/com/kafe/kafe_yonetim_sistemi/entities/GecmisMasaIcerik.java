package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class GecmisMasaIcerik {

    @Id
    private String id;

    @DBRef
    private Urun urun;

    private Date urunEklenmeTarihi;

    private Long urunAdet;

    private Date urunKaldirilmaTarihi;

    private boolean odenmeDurumu;
}
