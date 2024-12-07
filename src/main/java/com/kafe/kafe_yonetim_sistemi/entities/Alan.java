package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document(collection = "alan") // MongoDB'deki koleksiyon adı
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Alan {

    @Id
    private String id; // MongoDB'de genellikle String veya ObjectId kullanılır.

    @Field(name = "alan_ismi") // Alanı MongoDB'de farklı bir adla kaydetmek için
    private String alanIsmi;

    @Field(name = "olusturulma_tarihi")
    private Date olusturulmaTarihi;

    @Field(name = "son_guncelleme_tarihi")
    private Date sonGuncellemeTarihi;

}
