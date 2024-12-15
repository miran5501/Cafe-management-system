package com.kafe.kafe_yonetim_sistemi.repository;

import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.kafe.kafe_yonetim_sistemi.entities.RefreshToken;

@Repository
public interface RefreshTokenRepository extends MongoRepository<RefreshToken, String>{

    Optional<RefreshToken> findByRefreshToken(String refreshToken);
}
