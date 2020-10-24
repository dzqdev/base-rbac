package com.sise.base.controller.v1;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sise.base.annotation.Log;
import com.sise.base.configurer.RsaProperties;
import com.sise.base.core.CommonResult;
import com.sise.base.dto.SysUserDto;
import com.sise.base.dto.UpdateSysUserPasswordParam;
import com.sise.base.dto.query.SysUserQueryCriteria;
import com.sise.base.entity.SysUser;
import com.sise.base.service.ISysUserService;
import com.sise.base.utils.RsaUtils;
import com.sise.base.utils.SecurityUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.Set;

/**
 * <p>
 * 系统用户 前端控制器
 * </p>
 *
 * @author author
 * @since 2020-09-07
 */
@Api(tags = "系统：用户接口")
@RestController
@RequestMapping("/api/v1/sys-user")
public class SysUserController {

    @Resource
    private ISysUserService sysUserService;
    @Resource
    private PasswordEncoder passwordEncoder;


    @ApiOperation("查询用户")
    @GetMapping
    public CommonResult query(SysUserQueryCriteria criteria, Page page){
        return CommonResult.success(sysUserService.queryAll(criteria,page));
    }

    @Log("新增用户")
    @ApiOperation("新增用户")
    @PostMapping
    public CommonResult create(@RequestBody SysUserDto userDto){
        if(StrUtil.isEmpty(userDto.getUsername())){
            return CommonResult.failed("用户名称不能为空");
        }
        // 默认密码 123456
        userDto.setPassword(passwordEncoder.encode("123456"));
        sysUserService.create(userDto);
        return CommonResult.success(null);
    }

    @Log("修改用户")
    @ApiOperation("修改用户")
    @PutMapping
    public CommonResult update(SysUser user){
        sysUserService.updateById(user);
        return CommonResult.success(null);
    }

    @ApiOperation("修改用户：个人中心")
    @PutMapping(value = "center")
    public CommonResult center(SysUser user){
        if(!user.getId().equals(SecurityUtils.getCurrentUserId())){
            return CommonResult.failed("不能修改他人资料");
        }
        sysUserService.updateCenter(user);
        return CommonResult.success(null);
    }

    @Log("删除用户")
    @ApiOperation("删除用户")
    @DeleteMapping
    public CommonResult delete(@RequestBody Set<Long> ids){
        sysUserService.delete(ids);
        return CommonResult.success(null);
    }

    @Log("修改密码")
    @ApiOperation("修改密码")
    @PostMapping(value = "/updatePass")
    public CommonResult updatePass(@RequestBody UpdateSysUserPasswordParam passVo) throws Exception {
        String oldPass = RsaUtils.decryptByPrivateKey(RsaProperties.privateKey,passVo.getOldPass());
        String newPass = RsaUtils.decryptByPrivateKey(RsaProperties.privateKey,passVo.getNewPass());
        SysUserDto userDto = sysUserService.findByName(SecurityUtils.getCurrentUsername());
        if(!passwordEncoder.matches(oldPass, userDto.getPassword())){
            return CommonResult.failed("修改失败，旧密码错误");
        }
        if(passwordEncoder.matches(newPass, userDto.getPassword())){
            return CommonResult.failed("新密码不能与旧密码相同");
        }
        passVo.setUserId(SecurityUtils.getCurrentUserId().toString());
        passVo.setNewPass(passwordEncoder.encode(newPass));
        sysUserService.updatePassword(passVo);
        return CommonResult.success(null);
    }

    @ApiOperation("修改头像")
    @PostMapping(value = "/updateAvatar")
    public CommonResult updateAvatar(@RequestParam("file") MultipartFile file){
        return CommonResult.success(sysUserService.updateAvatar(file));
    }

}
