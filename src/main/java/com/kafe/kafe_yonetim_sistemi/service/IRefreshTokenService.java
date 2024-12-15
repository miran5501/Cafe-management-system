package com.kafe.kafe_yonetim_sistemi.service;

import com.kafe.kafe_yonetim_sistemi.jwt.AuthResponse;
import com.kafe.kafe_yonetim_sistemi.jwt.RefreshTokenRequest;

public interface IRefreshTokenService {

    public AuthResponse refreshToken(RefreshTokenRequest request);
}
