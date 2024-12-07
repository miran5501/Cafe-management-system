package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document(collection = "masa") // MongoDB'deki koleksiyon adı
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Masa {

    @Id
    private String id;

    @Field("alan_id")
    private String alanId;

    @Field(name = "masa_adi")
    private String masaAdi;

    @Field(name = "olusturulma_tarihi")
    private Date olusturulmaTarihi;

    @Field(name = "son_guncelleme_tarihi")
    private Date sonGuncellemeTarihi;

    @Field(name = "masa_durumu")
    private boolean masaDurumu;

    @Field(name="masa_icerik")
    private List<MasaIcerik> masaIcerikList;
}
