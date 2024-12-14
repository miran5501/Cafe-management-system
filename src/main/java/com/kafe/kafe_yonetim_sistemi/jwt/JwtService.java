package com.kafe.kafe_yonetim_sistemi.jwt;

import java.security.Key; // Düzeltilmiş
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtService {

    private static final String SECRET_KEY = "ZfNSKBB5Wr7nOeoO2SC03YiEjhBObcTKRyyw+l3N8+4=";

    public String generateToken(UserDetails userDetails) {
        Map<String, String> claimsMap=new HashMap<>();
        claimsMap.put("role", "ADMIN");
        return Jwts.builder()
                .setSubject(userDetails.getUsername())
                .setClaims(claimsMap)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 4)) // 4 saat
                .signWith(getKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public <T> T exportToken(String token, Function<Claims, T> claimsFunction){
        Claims claims=Jwts.parserBuilder()
        .setSigningKey(getKey())
        .build()
        .parseClaimsJws(token)
        .getBody();

        return claimsFunction.apply(claims);
    }

    public String getUsernameByToken(String token){
        return exportToken(token, Claims::getSubject);
    }

    public boolean isTokenExpired(String token){
        Date expiredDate=exportToken(token, Claims::getExpiration);
        return new Date().before(expiredDate);
    }

    private Key getKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
