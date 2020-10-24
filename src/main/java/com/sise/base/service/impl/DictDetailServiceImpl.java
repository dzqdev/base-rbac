package com.sise.base.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sise.base.dto.DictDetailDto;
import com.sise.base.dto.convert.DictDetailConvert;
import com.sise.base.dto.convert.PageConvert;
import com.sise.base.dto.query.DictDetailQueryCriteria;
import com.sise.base.entity.Dict;
import com.sise.base.entity.DictDetail;
import com.sise.base.mapper.DictDetailMapper;
import com.sise.base.service.IDictDetailService;
import com.sise.base.service.IDictService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 数据字典详情 服务实现类
 * </p>
 *
 * @author author
 * @since 2020-02-21
 */
@Service
public class DictDetailServiceImpl extends ServiceImpl<DictDetailMapper, DictDetail> implements IDictDetailService {

    @Resource
    private DictDetailMapper dictDetailMapper;
    @Resource
    private IDictService dictService;
    @Resource
    private PageConvert<DictDetailDto, DictDetail> pageConvert;
    @Resource
    private DictDetailConvert dictDetailConvert;

    @Override
    public Page<DictDetailDto> queryAll(DictDetailQueryCriteria criteria, Page pageable) {
        String dictName = criteria.getDictName();
        if(StringUtils.isNotEmpty(dictName)){
            Dict dict = dictService.getOne(new LambdaQueryWrapper<Dict>().eq(Dict::getName, dictName));
            Long dictId = dict == null ? null : dict.getId();
            LambdaQueryWrapper<DictDetail> dictDetailQuery = new LambdaQueryWrapper<>();
            dictDetailQuery.eq(DictDetail::getDictId, dictId);
            Page<DictDetail> page = dictDetailMapper.selectPage(pageable, dictDetailQuery);
            Page<DictDetailDto> dictDetailDtoPage = pageConvert.toPageDto(page, dictDetailConvert.toDto(page.getRecords()));
            return dictDetailDtoPage;
        }
        return null;
    }

    @Override
    public List<DictDetailDto> getDictByName(String name) {
        Dict dict = dictService.getOne(new LambdaQueryWrapper<Dict>().eq(Dict::getName, name));
        Long dictId = dict == null ? null : dict.getId();
        LambdaQueryWrapper<DictDetail> dictDetailQuery = new LambdaQueryWrapper<>();
        dictDetailQuery.eq(DictDetail::getDictId, dictId);
        return dictDetailConvert.toDto(list(dictDetailQuery));
    }
}
