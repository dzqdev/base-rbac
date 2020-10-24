package com.sise.base.vo;

import com.sise.base.entity.SysUser;
import lombok.Data;

import java.util.List;

@Data
public class SysUserVo extends SysUser {
    private List<String> roles;
}
