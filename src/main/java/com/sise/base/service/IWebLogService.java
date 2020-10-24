package com.sise.base.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sise.base.dto.query.WebLogQueryCriteria;
import com.sise.base.entity.WebLog;

/**
 * <p>
 * 操作日志 服务类
 * </p>
 *
 * @author author
 * @since 2020-08-25
 */
public interface IWebLogService extends IService<WebLog> {
    Page<WebLog> queryAll(WebLogQueryCriteria criteria, Page pageable);
}
