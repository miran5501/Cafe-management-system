package com.kafe.kafe_yonetim_sistemi.handler;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import com.kafe.kafe_yonetim_sistemi.exception.BaseException;

@ControllerAdvice
public class GlobalExceptionHandler<E> {

    @SuppressWarnings("rawtypes")
    @ExceptionHandler(value={BaseException.class})
    public ResponseEntity<ApiError> handleBaseException(BaseException exception, WebRequest request){
        return ResponseEntity.badRequest().body(createApiError(exception.getMessage(), request));
    }

    @SuppressWarnings("hiding")
    public <E> ApiError<E> createApiError(E message, WebRequest request){
        ApiError<E> apiError=new ApiError<>();
        apiError.setStatus(HttpStatus.BAD_REQUEST.value());

        Exception<E> exception=new Exception<>();
        exception.setCreateTime(new Date());
        exception.setHostName(getHostName());
        exception.setPath(request.getDescription(false));
        exception.setMessage(message);

        apiError.setException(exception);
        return apiError;
    }

    private String getHostName(){
        try{
            return InetAddress.getLocalHost().getHostName();
        }
        catch(UnknownHostException e){
            System.out.println("Hata oluştu" + e.getMessage());
        }
        return null;
        
    }

    
}
