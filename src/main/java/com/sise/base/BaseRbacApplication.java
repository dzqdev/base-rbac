package com.sise.base;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = "com.sise.base.mapper")
public class BaseRbacApplication {

    public static void main(String[] args) {
        SpringApplication.run(BaseRbacApplication.class, args);
    }

}
