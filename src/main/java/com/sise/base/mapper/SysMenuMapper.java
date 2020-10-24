package com.sise.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sise.base.entity.SysMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 系统菜单 Mapper 接口
 * </p>
 *
 * @author author
 * @since 2020-09-07
 */
public interface SysMenuMapper extends BaseMapper<SysMenu> {
    List<SysMenu> findByRoles(@Param("roleIds") Set<Long> roleIds, @Param("type") Integer type);
}
