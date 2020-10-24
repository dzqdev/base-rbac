package com.sise.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sise.base.entity.SysRole;
import com.sise.base.entity.SysUsersRoles;

import java.util.List;

/**
 * <p>
 * 用户角色关联 Mapper 接口
 * </p>
 *
 * @author author
 * @since 2020-09-07
 */
public interface SysUsersRolesMapper extends BaseMapper<SysUsersRoles> {
    List<SysRole> selectUserRoles(Long id);
}
