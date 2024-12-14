package com.kafe.kafe_yonetim_sistemi.controller;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;

public interface IRestAuthController {

    public DtoUser register(AuthRequest request);
}
