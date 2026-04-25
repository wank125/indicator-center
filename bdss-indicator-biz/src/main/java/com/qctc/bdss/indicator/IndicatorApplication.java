package com.qctc.bdss.indicator;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.qctc.bdss.indicator.mapper")
public class IndicatorApplication {

    public static void main(String[] args) {
        SpringApplication.run(IndicatorApplication.class, args);
    }
}
