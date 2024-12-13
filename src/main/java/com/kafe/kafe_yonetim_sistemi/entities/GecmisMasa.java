package com.kafe.kafe_yonetim_sistemi.entities;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "gecmis_masa")
public class GecmisMasa {

    @Id
    private String id;

    @Field(name="masa_id")
    private String masaId;

    @Field(name="toplam_tutar")
    private BigDecimal toplamTutar;

    @Field(name="masa_musteri_gelme_tarihi")
    private Date masaMusteriGelmeTarihi;

    @Field(name="masa_musteri_gitme_tarihi")
    private Date masaMusteriGitmeTarihi;

    @Field(name="gecmis_masa_icerik")
    private List<GecmisMasaIcerik> gecmisMasaIcerikList;
}
