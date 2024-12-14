package com.kafe.kafe_yonetim_sistemi.controller.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.kafe.kafe_yonetim_sistemi.controller.IRestAuthController;
import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;
import com.kafe.kafe_yonetim_sistemi.service.IAuthService;

import jakarta.validation.Valid;

@RestController
public class RestAuthControllerImpl implements IRestAuthController{

    @Autowired
    private IAuthService authService;

    @PostMapping("/register")
    @Override
    public DtoUser register(@Valid @RequestBody AuthRequest request) {
        return authService.register(request);
    }

}
