package com.kafe.kafe_yonetim_sistemi.controller.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kafe.kafe_yonetim_sistemi.controller.IGecmisMasaController;
import com.kafe.kafe_yonetim_sistemi.dto.DtoGecmisMasa;
import com.kafe.kafe_yonetim_sistemi.service.IGecmisMasaService;

@CrossOrigin
@RestController
@RequestMapping("api/gecmis-masa")
public class GecmisMasaControllerImpl implements IGecmisMasaController{

    @Autowired
    private IGecmisMasaService gecmisMasaService;

    @GetMapping(path="/getir")
    @Override
    public List<DtoGecmisMasa> getAllGecmisMasa() {
        return gecmisMasaService.getAllGecmisMasa();
    }

    @GetMapping(path="/getir/{id}")
    @Override
    public DtoGecmisMasa getGecmisMasa(@PathVariable(name="id") String id) {
        return gecmisMasaService.getGecmisMasa(id);
    }

}
