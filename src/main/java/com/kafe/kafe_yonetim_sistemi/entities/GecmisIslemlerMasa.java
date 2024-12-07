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


@NoArgsConstructor
@AllArgsConstructor
@Data
@Document(collection= "gecmis_islemler_masa")
public class GecmisIslemlerMasa {

    @Id
    private String id;

    @Field(name="musteri_gelme_tarihi")
    private Date musteriGelmeTarihi;

    @Field(name="musteri_gitme_tarihi")
    private Date musteriGitmeTarihi;

    @Field(name="tutar")
    private BigDecimal tutar;

    @DBRef
    @Field(name = "masa")
    private Masa masa;
}
