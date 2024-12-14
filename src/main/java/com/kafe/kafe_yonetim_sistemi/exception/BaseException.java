package com.kafe.kafe_yonetim_sistemi.exception;

public class BaseException extends RuntimeException{

    public BaseException(ErrorMessage errorMessage){
        super(errorMessage.prepareErrorMessage());
    }

}
