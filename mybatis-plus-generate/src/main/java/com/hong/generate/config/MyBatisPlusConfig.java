package com.hong.generate.config;

//import com.baomidou.mybatisplus.extension.injector.LogicSqlInjector;

import com.baomidou.mybatisplus.extension.plugins.OptimisticLockerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @description:
 * @author: YJH
 * @time: 2020/4/5 10:25
 */
@MapperScan("com.digitfacory.springbootdemo.mapper")
@EnableTransactionManagement
// 配置类
@Configuration
public class MyBatisPlusConfig {

    // 乐观锁插件
    @Bean
    public OptimisticLockerInterceptor optimisticLockerInterceptor() {
        return new OptimisticLockerInterceptor();
    }

    // 分页插件
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        return  new PaginationInterceptor();
    }

    // 逻辑删除
    /*@Bean
    public ISqlInjector sqlInjector() {
        return new LogicSqlInjector();
    }*/

    /**
     * SQL执行效率插件
     */
    /*@Bean
    @Profile({"dev","test"})// 设置 dev test 环境开启，保证我们的效率
    public PerformanceInterceptor performanceInterceptor() {
        PerformanceInterceptor performanceInterceptor = new PerformanceInterceptor();
        performanceInterceptor.setMaxTime(100); //ms 设置sql执行的最大时间，如果超过了则不执行
        performanceInterceptor.setFormat(true);
        return performanceInterceptor;
    }*/

}
