package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.sql.Date;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.entities.RefreshToken;
import com.kafe.kafe_yonetim_sistemi.entities.User;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthResponse;
import com.kafe.kafe_yonetim_sistemi.jwt.JwtService;
import com.kafe.kafe_yonetim_sistemi.repository.RefreshTokenRepository;
import com.kafe.kafe_yonetim_sistemi.repository.UserRepository;
import com.kafe.kafe_yonetim_sistemi.service.IAuthService;

@Service
public class AuthServiceImpl implements IAuthService{

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    private AuthenticationProvider authenticationProvider;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    private RefreshToken createRefreshToken(String userId){
        RefreshToken refreshToken=new RefreshToken();
        refreshToken.setRefreshToken(UUID.randomUUID().toString());
        refreshToken.setExpireDate(new Date(System.currentTimeMillis()+1000*60*60*4));
        refreshToken.setUserId(userId);

        return refreshToken;
    }

    @Override
    public DtoUser register(AuthRequest request) {
        User user=new User();
        DtoUser dtoUser=new DtoUser();
        user.setUsername(request.getUsername());
        user.setPassword(passwordEncoder.encode(request.getPassword()));

        User dbUser = userRepository.save(user);
        BeanUtils.copyProperties(dbUser, dtoUser);
        return dtoUser;
    }

    @Override
    public AuthResponse authenticate(AuthRequest request) {
        try {
            UsernamePasswordAuthenticationToken auth=new UsernamePasswordAuthenticationToken
            (request.getUsername(), request.getPassword());
            authenticationProvider.authenticate(auth);
            Optional<User> optional=userRepository.findByUsername(request.getUsername());
            if(optional.isPresent()){
                User user=optional.get();
                String accessToken = jwtService.generateToken(user);
                RefreshToken refreshToken=createRefreshToken(user.getId());
                RefreshToken dbRefreshToken=refreshTokenRepository.save(refreshToken);

                return new AuthResponse(accessToken, dbRefreshToken.getRefreshToken());
            }
            else{
                return null;
            }
            
        } catch (AuthenticationException e) {
            System.out.println("kullanıcı adı veya şifre hatalı"+e.getMessage());
        }



        return null;
    }

}
