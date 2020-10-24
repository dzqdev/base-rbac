package com.sise.base.dto.convert;

import com.sise.base.dto.SysMenuDto;
import com.sise.base.entity.SysMenu;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface SysMenuConvert extends BaseMapper<SysMenuDto, SysMenu> {
}
