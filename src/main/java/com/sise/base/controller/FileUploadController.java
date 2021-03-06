package com.sise.base.controller;

import cn.hutool.core.util.ObjectUtil;
import com.sise.base.core.CommonResult;
import com.sise.base.utils.FileProperties;
import com.sise.base.utils.FileUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;

@RestController
@RequestMapping("/api/v1/upload")
@Api(tags = "文件上传")
public class FileUploadController {

    @Resource
    private FileProperties properties;

    @ApiOperation("上传文件并返回文件访问地址")
    @PostMapping
    public CommonResult upload(MultipartFile multipartFile){
        FileUtil.checkSize(properties.getMaxSize(), multipartFile.getSize());
        String suffix = FileUtil.getExtensionName(multipartFile.getOriginalFilename());
        String type = FileUtil.getFileType(suffix);
        File file = FileUtil.upload(multipartFile, properties.getPath().getPath() + type +  File.separator);
        if(ObjectUtil.isNull(file)){
            return CommonResult.failed("上传失败");
        }
        return CommonResult.success(file.getPath());
    }

}
