package com.sise.base.security.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sise.base.core.ResultCode;
import com.sise.base.dto.SysUserDto;
import com.sise.base.dto.convert.SysUserConvert;
import com.sise.base.entity.SysUser;
import com.sise.base.exception.Asserts;
import com.sise.base.security.dto.JwtUserDto;
import com.sise.base.service.ISysRoleService;
import com.sise.base.service.ISysUserService;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service("userDetailsService")
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public class UserDetailsServiceImpl implements UserDetailsService {

    @Resource
    private ISysUserService userService;
    @Resource
    private ISysRoleService roleService;

    @Resource
    private SysUserConvert sysUserConvert;

    @Override
    public JwtUserDto loadUserByUsername(String username) {
        SysUserDto sysUserDto = null;
        try {
            SysUser sysUser = userService.getOne(new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, username));
            sysUserDto = sysUserConvert.toDto(sysUser);
        } catch (UsernameNotFoundException e) {
            Asserts.fail(ResultCode.UN_AUTHORIZED);
        }
        if (sysUserDto == null) {
            throw new UsernameNotFoundException("");
        } else {
            if (!sysUserDto.getEnabled()) {
                Asserts.fail("账号未激活");
            }
            return new JwtUserDto(
                    sysUserDto,
                    roleService.mapToGrantedAuthorities(sysUserDto)
            );
        }
    }
}
