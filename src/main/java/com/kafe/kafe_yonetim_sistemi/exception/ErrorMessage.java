package com.kafe.kafe_yonetim_sistemi.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ErrorMessage {

    private MessageType messageType;

    private String ofStatic;

    public String prepareErrorMessage(){
        StringBuilder builder = new StringBuilder();
        builder.append(messageType.getMessage());
        if(ofStatic!=null){
            builder.append(" : ").append(ofStatic);
        }
        return builder.toString();
    }

}