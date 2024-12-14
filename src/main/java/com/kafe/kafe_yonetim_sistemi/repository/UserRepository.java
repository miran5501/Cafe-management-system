package com.kafe.kafe_yonetim_sistemi.repository;

import java.util.Optional;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.kafe.kafe_yonetim_sistemi.entities.User;

@Repository
public interface UserRepository extends MongoRepository<User, String>{

    Optional<User> findByUsername(String username);
}
