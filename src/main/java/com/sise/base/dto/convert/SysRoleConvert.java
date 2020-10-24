package com.sise.base.dto.convert;

import com.sise.base.dto.SysRoleDto;
import com.sise.base.entity.SysRole;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface SysRoleConvert extends BaseMapper<SysRoleDto, SysRole>{
}
