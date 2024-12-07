package com.kafe.kafe_yonetim_sistemi.exception;

import lombok.Getter;

@Getter
public enum MessageType {

    NO_RECORD_EXIST("1001","kayıt bulunamadı"),
    GENERAL_EXCEPTION("9999","genel bir hata oluştu");

    private final String code;
    private final String message;

    MessageType(String code, String message){
        this.code=code;
        this.message=message;
    }

    
}