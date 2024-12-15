package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Date;
import java.util.UUID;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MasaIcerik {

    @Id
    private String id = UUID.randomUUID().toString();

    @DBRef
    private Urun urun;

    private Date urunEklenmeTarihi;

    private Long urunAdet;

    private Date urunKaldirilmaTarihi;

    private boolean odenmeDurumu;
}
