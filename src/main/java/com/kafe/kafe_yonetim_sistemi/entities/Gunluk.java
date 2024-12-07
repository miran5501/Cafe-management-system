package com.kafe.kafe_yonetim_sistemi.entities;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
@Document(collection="gunluk")
public class Gunluk {

    @Id
    private String id;

    @Field(name="tarih")
    private Date tarih;

    @Field(name="toplam_tutar")
    private BigDecimal toplamTutar;

}
