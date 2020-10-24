package com.sise.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sise.base.entity.SysMenu;
import com.sise.base.entity.SysRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 角色表 Mapper 接口
 * </p>
 *
 * @author author
 * @since 2020-09-07
 */
public interface SysRoleMapper extends BaseMapper<SysRole> {
    public List<SysMenu> getMenuList(Long roleId);

    void untiedMenu(@Param("id") Long id);
}
