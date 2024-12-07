package com.kafe.kafe_yonetim_sistemi.entities;

import java.math.BigDecimal;
import java.util.Date;

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
@Document(collection = "gecmis_islemler")
public class GecmisIslemler {

    @Id
    private String id;

    @Field(name="adet")
    private Long adet;

    @Field(name="tutar")
    private BigDecimal tutar;

    @Field(name="urun_eklenme_tarihi")
    private Date urunEklenmeTarihi;

    @DBRef
    @Field(name="urun")
    private Urun urun;

    @DBRef
    @Field(name="gecmis_islemler_masa")
    private GecmisIslemlerMasa gecmisIslemlerMasa;


}
