package com.kafe.kafe_yonetim_sistemi.entities;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection="urunler")
public class Urun {

    @Id
    private String id;

    @Field(name="urun_adi")
    private String urunAdi;

    @Field(name="fiyat")
    private BigDecimal fiyat;

    @Field(name="olusturulma_tarihi")
    private Date olusturulmaTarihi;

    @Field(name="son_guncelleme_tarihi")
    private Date sonGuncellemeTarihi;

    @Field(name="stok")
    private Long stok;

    @Field(name = "kategori_id")
    private String kategoriId;

}
