package com.kafe.kafe_yonetim_sistemi.handler;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApiError<E> {

    private Integer status;

    private Exception<E> exception;
}