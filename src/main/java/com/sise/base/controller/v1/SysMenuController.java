package com.sise.base.controller.v1;


import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sise.base.annotation.Log;
import com.sise.base.core.CommonResult;
import com.sise.base.dto.SysMenuDto;
import com.sise.base.dto.convert.SysMenuConvert;
import com.sise.base.dto.query.SysMenuQueryCriteria;
import com.sise.base.entity.SysMenu;
import com.sise.base.entity.SysRole;
import com.sise.base.entity.SysUser;
import com.sise.base.service.ISysMenuService;
import com.sise.base.service.ISysRoleService;
import com.sise.base.service.ISysUserService;
import com.sise.base.utils.SecurityUtils;
import com.sise.base.vo.MenuVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

/**
 * <p>
 * 系统菜单 前端控制器
 * </p>
 *
 * @author author
 * @since 2020-09-07
 */
@RestController
@RequestMapping("/api/v1/menu")
@Api(tags = "系统：菜单接口")
public class SysMenuController {

    @Resource
    private ISysMenuService menuService;

    @Resource
    private ISysRoleService roleService;

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private SysMenuConvert sysMenuConvert;

    @Log("新增菜单")
    @ApiOperation("新增菜单")
    @PostMapping
    public CommonResult create(SysMenu sysMenu){
        menuService.create(sysMenu);
        return CommonResult.success(null);
    }

    @Log("修改菜单")
    @ApiOperation("修改菜单")
    @PutMapping
    public CommonResult update(@RequestBody SysMenu sysMenu){
        menuService.update(sysMenu);
        return CommonResult.success(null);
    }

    @Log("删除菜单")
    @ApiOperation("删除菜单")
    @DeleteMapping
    public CommonResult delete(@RequestBody Set<Long> ids){
        //删除菜单本身以及子菜单
        Set<SysMenu> menuSet = new HashSet<>();
        for (Long id : ids) {
            List<SysMenuDto> menuList = menuService.getMenus(id);
            menuSet.add(menuService.getById(id));
            menuSet = menuService.getDeleteMenus(sysMenuConvert.toEntity(menuList), menuSet);
        }
        menuService.delete(menuSet);
        return CommonResult.success(null);
    }

    @ApiOperation("查询菜单")
    @GetMapping
    public CommonResult query(SysMenuQueryCriteria queryCriteria) {
        List<SysMenuDto> menus = menuService.queryAll(queryCriteria);
        return CommonResult.success(menus);
    }

    @ApiOperation("返回全部的菜单")
    @GetMapping(value = "/lazy")
    public CommonResult query(@RequestParam Long pid){
        List<SysMenuDto> menus = menuService.getMenus(pid);
        return CommonResult.success(menus);
    }


    @ApiOperation("获取前端所需菜单")
    @GetMapping(value = "/build")
    public CommonResult buildMenus(){
        SysUser user = sysUserService.getOne(new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, SecurityUtils.getCurrentUsername()));
        List<SysRole> roles = sysUserService.getUserRoleList(Long.valueOf(user.getId()));
        List<SysMenuDto> sysMenuDtos = menuService.findByRoles(roles,2);
        List<SysMenuDto> treeMuenuDtos = menuService.buildTree(sysMenuDtos);
        List<MenuVo> menus = menuService.buildMenus(treeMuenuDtos);
        return CommonResult.success(menus);
    }

    @ApiOperation("查询菜单:根据ID获取同级与上级数据")
    @PostMapping("/superior")
    public CommonResult getSuperior(@RequestBody List<Long> ids) {
        Set<SysMenuDto> menuDtos = new LinkedHashSet<>();
        if(CollectionUtil.isNotEmpty(ids)){
            for (Long id : ids) {
                SysMenu menu = menuService.getById(id);
                SysMenuDto menuDto = sysMenuConvert.toDto(menu);
                menuDtos.addAll(menuService.getSuperior(menuDto, new ArrayList<>()));
            }
            return CommonResult.success(menuService.buildTree(new ArrayList<>(menuDtos)));
        }
        return CommonResult.success(menuService.getMenus(null));
    }
}
