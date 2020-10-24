package com.sise.base.controller.v1;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sise.base.core.CommonResult;
import com.sise.base.dto.DictDetailDto;
import com.sise.base.dto.query.DictDetailQueryCriteria;
import com.sise.base.entity.DictDetail;
import com.sise.base.service.IDictDetailService;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 数据字典详情 前端控制器
 * </p>
 *
 * @author author
 * @since 2020-02-21
 */
@RestController
@RequestMapping(value = {"api/v1/dictDetail","api/v2/dictDetail"})
public class DictDetailController {

    @Resource
    private IDictDetailService dictDetailService;

    @ApiOperation("查询字典详情")
    @GetMapping
    public CommonResult query(DictDetailQueryCriteria criteria, Page pageable){
        return CommonResult.success(dictDetailService.queryAll(criteria, pageable));
    }

    @ApiOperation("查询多个字典详情")
    @GetMapping(value = "/map")
    public CommonResult getDictDetailMaps(@RequestParam String dictName){
        String[] names = dictName.split("[,，]");
        Map<String, List<DictDetailDto>> dictMap = new HashMap<>(16);
        for (String name : names) {
            dictMap.put(name, dictDetailService.getDictByName(name));
        }
        return CommonResult.success(dictMap);
    }

    @ApiOperation("新增字典详情")
    @PostMapping
    public CommonResult create(@Validated @RequestBody DictDetail resources){
        resources.setCreateTime(new Date());
        dictDetailService.save(resources);
        return CommonResult.success(null);
    }

    @ApiOperation("修改字典详情")
    @PutMapping
    public CommonResult update(@RequestBody DictDetail resources){
        dictDetailService.updateById(resources);
        return CommonResult.success(null);
    }

    @ApiOperation("删除字典详情")
    @DeleteMapping(value = "/{id}")
    public CommonResult delete(@PathVariable Long id){
        dictDetailService.removeById(id);
        return CommonResult.success(null);
    }

}
