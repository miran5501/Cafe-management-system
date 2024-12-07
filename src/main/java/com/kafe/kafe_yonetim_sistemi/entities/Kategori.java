package com.kafe.kafe_yonetim_sistemi.entities;

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
@Document(collection = "kategori")
public class Kategori {

    @Id
    private String id;

    @Field(name="kategori_ismi")
    private String kategoriIsmi;

    @Field(name="olusturulma_tarihi")
    private Date olusturulmaTarihi;

    @Field(name="son_guncelleme_tarihi")
    private Date sonGuncellemeTarihi;
}
