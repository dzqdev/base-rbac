package com.sise.base.dto.convert;

import com.sise.base.dto.SysUserDto;
import com.sise.base.dto.format.BooleanFormatter;
import com.sise.base.entity.SysUser;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", uses = {BooleanFormatter.class}, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface SysUserConvert extends BaseMapper<SysUserDto, SysUser> {

}
