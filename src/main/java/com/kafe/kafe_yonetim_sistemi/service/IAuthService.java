package com.kafe.kafe_yonetim_sistemi.service;

import org.springframework.web.bind.annotation.RequestBody;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthResponse;

public interface IAuthService {

    public DtoUser register(AuthRequest request);

    public AuthResponse authenticate(@RequestBody AuthRequest request);
}
