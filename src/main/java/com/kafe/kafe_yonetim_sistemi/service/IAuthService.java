package com.kafe.kafe_yonetim_sistemi.service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;

public interface IAuthService {

    public DtoUser register(AuthRequest request);
}
