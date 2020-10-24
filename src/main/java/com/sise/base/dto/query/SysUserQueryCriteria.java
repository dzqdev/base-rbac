package com.sise.base.dto.query;

import lombok.Data;

import java.sql.Timestamp;
import java.util.List;

@Data
public class SysUserQueryCriteria {

    private Long id;

    private String blurry;

    private Boolean enabled;

    private List<Timestamp> createTime;
}
