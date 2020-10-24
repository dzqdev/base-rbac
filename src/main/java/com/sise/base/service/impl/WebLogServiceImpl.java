package com.sise.base.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sise.base.dto.query.WebLogQueryCriteria;
import com.sise.base.entity.WebLog;
import com.sise.base.mapper.WebLogMapper;
import com.sise.base.service.IWebLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 * 操作日志 服务实现类
 * </p>
 *
 * @author author
 * @since 2020-08-25
 */
@Service
public class WebLogServiceImpl extends ServiceImpl<WebLogMapper, WebLog> implements IWebLogService {

    @Resource
    private WebLogMapper webLogMapper;

    @Override
    public Page<WebLog> queryAll(WebLogQueryCriteria criteria, Page pageable) {
        LambdaQueryWrapper<WebLog> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(WebLog::getUsername, criteria.getUsername());
        Page<WebLog> page = webLogMapper.selectPage(pageable, queryWrapper);
        return page;
    }
}
