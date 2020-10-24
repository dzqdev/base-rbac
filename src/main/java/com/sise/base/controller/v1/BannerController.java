package com.sise.base.controller.v1;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sise.base.annotation.Log;
import com.sise.base.core.CommonResult;
import com.sise.base.entity.Banner;
import com.sise.base.service.IBannerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Set;

/**
 * <p>
 * 轮播图 前端控制器
 * </p>
 *
 * @author author
 * @since 2020-10-23
 */

@RestController
@RequestMapping("/api/v1/banner")
@Api(tags = "系统管理：轮播图")
public class BannerController {
    @Resource
    IBannerService bannerService;

    @ApiOperation("查询轮播图列表")
    @GetMapping
    public CommonResult queryAll(Page page){
        return CommonResult.success(null);
    }

    @Log("新增轮播")
    @ApiOperation("新增轮播")
    @PostMapping
    public CommonResult create(@RequestBody Banner banner){
        bannerService.save(banner);
        return CommonResult.success(null);
    }

    @Log("修改轮播图显示状态")
    @ApiOperation("修改轮播图显示状态")
    @PutMapping("state")
    public CommonResult updateState(Banner banner){
        Banner systemBanner = bannerService.getById(banner.getId());
        if(systemBanner != null){
            systemBanner.setState(banner.getState());
            bannerService.updateById(systemBanner);
            return CommonResult.success(null);
        }else{
            return CommonResult.failed("修改的轮播图不存在");
        }
    }

    @Log("修改轮播")
    @ApiOperation("修改轮播")
    @PutMapping
    public CommonResult update(Banner banner){
        bannerService.updateById(banner);
        return CommonResult.success(null);
    }


    @Log("删除轮播")
    @ApiOperation("删除轮播")
    @DeleteMapping
    public CommonResult delete(@RequestBody Set<Long> ids){
        bannerService.removeByIds(ids);
        return CommonResult.success(null);
    }
}
