package com.kafe.kafe_yonetim_sistemi.service.impl;

import java.util.Date;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.entities.RefreshToken;
import com.kafe.kafe_yonetim_sistemi.entities.User;
import com.kafe.kafe_yonetim_sistemi.exception.BaseException;
import com.kafe.kafe_yonetim_sistemi.exception.ErrorMessage;
import com.kafe.kafe_yonetim_sistemi.exception.MessageType;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthResponse;
import com.kafe.kafe_yonetim_sistemi.jwt.JwtService;
import com.kafe.kafe_yonetim_sistemi.jwt.RefreshTokenRequest;
import com.kafe.kafe_yonetim_sistemi.repository.RefreshTokenRepository;
import com.kafe.kafe_yonetim_sistemi.repository.UserRepository;
import com.kafe.kafe_yonetim_sistemi.service.IRefreshTokenService;

@Service
public class RefreshTokenServiceImpl implements IRefreshTokenService{

    @Autowired
    private RefreshTokenRepository refreshTokenRepository;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private UserRepository userRepository;

    public boolean isRefreshTokenExpired(Date expiredDate){
        return new Date().before(expiredDate);
    }

    private RefreshToken createRefreshToken(String userId){
        RefreshToken refreshToken=new RefreshToken();
        refreshToken.setRefreshToken(UUID.randomUUID().toString());
        refreshToken.setExpireDate(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 4));
        refreshToken.setUserId(userId);

        return refreshToken;
    }

    @Override
    public AuthResponse refreshToken(RefreshTokenRequest request) {
        Optional<RefreshToken> optional= refreshTokenRepository.findByRefreshToken(request.getRefreshToken());
        if(optional.isPresent()){
            RefreshToken refreshToken=optional.get();
            if(!isRefreshTokenExpired(refreshToken.getExpireDate())){
                throw new BaseException(new ErrorMessage(MessageType.GENERAL_EXCEPTION, "Tokenin süresi dolmuştur!"));
            }
            else{
                Optional<User> optionalUser=userRepository.findById(refreshToken.getUserId());
                if(optionalUser.isPresent()){
                    User user = optionalUser.get();
                    String accessToken=jwtService.generateToken(user);
                    RefreshToken savedRefreshToken=refreshTokenRepository.save(createRefreshToken(refreshToken.getUserId()));

                    return new AuthResponse(accessToken,savedRefreshToken.getRefreshToken());
                }
                else{
                    throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Bu id ile kullanıcı bulunmamaktadır!"));
                }
            }
        }
        else{
            throw new BaseException(new ErrorMessage(MessageType.NO_RECORD_EXIST, "Böyle bir token bulunmamaktadır!"));
        }
    }

}
