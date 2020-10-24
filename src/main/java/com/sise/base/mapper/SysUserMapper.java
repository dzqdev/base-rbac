package com.sise.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sise.base.dto.SysUserDto;
import com.sise.base.entity.SysRole;
import com.sise.base.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统用户 Mapper 接口
 * </p>
 *
 * @author author
 * @since 2020-09-07
 */
public interface SysUserMapper extends BaseMapper<SysUser> {
    IPage<SysUserDto> query(@Param("user") SysUserDto user, Page page);

    //查询用户拥有的所有角色
    List<SysRole> getRoleList(@Param("userId") Long userId);
}
