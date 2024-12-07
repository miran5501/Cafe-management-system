package com.kafe.kafe_yonetim_sistemi.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.kafe.kafe_yonetim_sistemi.entities.Urun;

@Repository
public interface UrunRepository extends MongoRepository<Urun, String>{

    // Kategori ID'si ile ürünleri bulma
    List<Urun> findByKategoriId(String kategoriId);  // 'kategoriId' burada, 'Kategori_Id' yerine
}
