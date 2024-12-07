package com.kafe.kafe_yonetim_sistemi.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.kafe.kafe_yonetim_sistemi.entities.Masa;

@Repository
public interface MasaRepository extends MongoRepository<Masa, String>{

    List<Masa> findByAlanId(String alanId);
}
