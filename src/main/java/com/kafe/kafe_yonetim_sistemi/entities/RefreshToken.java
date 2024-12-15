package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document(collection = "refresh_token") // MongoDB'deki koleksiyon adı
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RefreshToken {

    @Id
    private String id;

    @Field("refresh_token")
    private String refreshToken;

    @Field("expire_date")
    private Date expireDate;

    @Field("user_id")
    private String userId;

}
