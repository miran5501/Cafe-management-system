package com.kafe.kafe_yonetim_sistemi.controller;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthResponse;
import com.kafe.kafe_yonetim_sistemi.jwt.RefreshTokenRequest;

public interface IRestAuthController {

    public DtoUser register(AuthRequest request);

    public AuthResponse authenticate(AuthRequest request);

    public AuthResponse refreshToken(RefreshTokenRequest request);
}
