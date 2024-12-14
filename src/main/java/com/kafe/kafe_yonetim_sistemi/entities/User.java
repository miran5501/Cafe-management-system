package com.kafe.kafe_yonetim_sistemi.entities;

import java.util.Collection;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "user")
public class User implements UserDetails{

    @Id
    private String id;

    @Field(name="user_name")
    private String username;

    @Field(name="password")
    private String password;

    @Field(name="isim")
    private String isim;

    @Field(name="soyisim")
    private String soyisim;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

}
