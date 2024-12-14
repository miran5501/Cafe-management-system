package com.kafe.kafe_yonetim_sistemi.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kafe.kafe_yonetim_sistemi.dto.DtoUser;
import com.kafe.kafe_yonetim_sistemi.entities.User;
import com.kafe.kafe_yonetim_sistemi.jwt.AuthRequest;
import com.kafe.kafe_yonetim_sistemi.repository.UserRepository;
import com.kafe.kafe_yonetim_sistemi.service.IAuthService;

@Service
public class AuthServiceImpl implements IAuthService{

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

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

}
