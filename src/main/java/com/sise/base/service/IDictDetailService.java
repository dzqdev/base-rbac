package com.sise.base.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sise.base.dto.DictDetailDto;
import com.sise.base.dto.query.DictDetailQueryCriteria;
import com.sise.base.entity.DictDetail;

import java.util.List;

/**
 * <p>
 * 数据字典详情 服务类
 * </p>
 *
 * @author author
 * @since 2020-02-21
 */
public interface IDictDetailService extends IService<DictDetail> {

    Page<DictDetailDto> queryAll(DictDetailQueryCriteria criteria, Page pageable);

    List<DictDetailDto> getDictByName(String name);
}
