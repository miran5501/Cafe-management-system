package com.kafe.kafe_yonetim_sistemi.jwt;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthRequest {

    @NotEmpty
    private String username;

    @NotEmpty
    private String password;
}