package com.sise.base.dto;


import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class UpdateSysUserPasswordParam {
    @ApiModelProperty(value = "用户id", required = true)
    private String userId;
    @ApiModelProperty(value = "旧密码", required = true)
    private String oldPassword;
    @ApiModelProperty(value = "新密码", required = true)
    private String newPassword;
}
