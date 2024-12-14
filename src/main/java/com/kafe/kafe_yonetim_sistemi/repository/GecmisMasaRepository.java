package com.kafe.kafe_yonetim_sistemi.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.kafe.kafe_yonetim_sistemi.entities.GecmisMasa;

@Repository
public interface GecmisMasaRepository extends MongoRepository<GecmisMasa, String>{

}
