package com.sise.base.security.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AuthUserDto {

    private String username;

    private String password;

    private String code;

    private String uuid = "";

    @Override
    public String toString() {
        return "{username=" + username  + ", password= ******}";
    }
}
