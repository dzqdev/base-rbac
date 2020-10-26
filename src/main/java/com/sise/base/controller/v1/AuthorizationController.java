package com.sise.base.controller.v1;

import cn.hutool.core.util.IdUtil;
import com.sise.base.annotation.AnonymousAccess;
import com.sise.base.annotation.Log;
import com.sise.base.configurer.LoginCodeEnum;
import com.sise.base.configurer.LoginProperties;
import com.sise.base.core.CommonResult;
import com.sise.base.security.config.SecurityProperties;
import com.sise.base.security.dto.AuthUserDto;
import com.sise.base.security.dto.JwtUserDto;
import com.sise.base.security.security.TokenProvider;
import com.sise.base.security.service.OnlineUserService;
import com.sise.base.utils.RedisUtils;
import com.sise.base.utils.SecurityUtils;
import com.wf.captcha.base.Captcha;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 授权、根据token获取用户详细信息
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/auth")
@Api(tags = "系统：系统授权接口")
public class AuthorizationController {
    @Resource
    private SecurityProperties properties;
    @Resource
    private RedisUtils redisUtils;
    @Resource
    private OnlineUserService onlineUserService;
    @Resource
    private TokenProvider tokenProvider;
    @Resource
    private AuthenticationManagerBuilder authenticationManagerBuilder;
    @Resource
    private LoginProperties loginProperties;


    @Log("用户登录")
    @PostMapping(value = "/login")
    @ApiOperation("登录授权")
    @AnonymousAccess
    public CommonResult login(@Validated AuthUserDto authUser, HttpServletRequest request) throws Exception {
        // 密码解密
        String password = authUser.getPassword();
       /* // 查询验证码
        String code = (String) redisUtils.get(authUser.getUuid());
        // 清除验证码
        redisUtils.del(authUser.getUuid());
        if (StringUtils.isBlank(code)) {
            Asserts.fail("验证码不存在或已过期");
        }
        if (StringUtils.isBlank(authUser.getCode()) || !authUser.getCode().equalsIgnoreCase(code)) {
            Asserts.fail("验证码错误");
        }*/
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(authUser.getUsername(), password);
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        // 生成令牌
        String token = tokenProvider.createToken(authentication);
        final JwtUserDto jwtUserDto = (JwtUserDto) authentication.getPrincipal();
        // 保存在线信息
        onlineUserService.save(jwtUserDto, token, request);
        // 返回 token 与 用户信息
        Map<String, Object> authInfo = new HashMap<String, Object>(2) {{
            put("token", properties.getTokenStartWith() + token);
            put("user", jwtUserDto);
        }};
        if (loginProperties.isSingleLogin()) {
            //踢掉之前已经登录的token
            onlineUserService.checkLoginOnUser(authUser.getUsername(), token);
        }
        return CommonResult.success(authInfo);
    }

    @ApiOperation("获取用户信息")
    @GetMapping(value = "/info")
    public CommonResult getUserInfo() {
        return CommonResult.success(SecurityUtils.getCurrentUser());
    }

    @GetMapping(value = "/code")
    @ApiOperation("获取验证码")
    @AnonymousAccess
    public CommonResult getCode() {
        // 获取运算的结果
        Captcha captcha = loginProperties.getCaptcha();
        String uuid = properties.getCodeKey() + IdUtil.simpleUUID();
        //当验证码类型为 arithmetic时且长度 >= 2 时，captcha.text()的结果有几率为浮点型
        String captchaValue = captcha.text();
        if (captcha.getCharType() - 1 == LoginCodeEnum.arithmetic.ordinal() && captchaValue.contains(".")) {
            captchaValue = captchaValue.split("\\.")[0];
        }
        // 保存
        redisUtils.set(uuid, captchaValue, loginProperties.getLoginCode().getExpiration(), TimeUnit.MINUTES);
        // 验证码信息
        Map<String, Object> imgResult = new HashMap<String, Object>(2) {{
            put("img", captcha.toBase64());
            put("uuid", uuid);
        }};
        return CommonResult.success(imgResult);
    }

    @ApiOperation("退出登录")
    @AnonymousAccess
    @DeleteMapping(value = "logout")
    public CommonResult logout(HttpServletRequest request) {
        onlineUserService.logout(tokenProvider.getToken(request));
        return CommonResult.success(null);
    }
}
