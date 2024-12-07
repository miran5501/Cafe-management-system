package com.kafe.kafe_yonetim_sistemi.entities;

import java.math.BigDecimal;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection="gunluk_satilanlar")
public class GunlukSatilanlar {

    @Id
    private String id;

    @DBRef
    @Field(name = "urun")
    private Urun urun;

    @Field(name="adet")
    private Long adet;

    @Field(name="toplam_fiyat")
    private BigDecimal toplamFiyat;

    @DBRef
    @Field(name = "gunluk")
    private Gunluk gunluk;
}
