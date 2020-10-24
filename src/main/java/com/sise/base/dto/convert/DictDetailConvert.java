package com.sise.base.dto.convert;

import com.sise.base.dto.DictDetailDto;
import com.sise.base.entity.DictDetail;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface DictDetailConvert extends BaseMapper<DictDetailDto, DictDetail> {
}
