package com.sise.base.dto.convert;

import com.sise.base.dto.DictDto;
import com.sise.base.entity.Dict;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface DictConvert extends BaseMapper<DictDto, Dict> {
}
