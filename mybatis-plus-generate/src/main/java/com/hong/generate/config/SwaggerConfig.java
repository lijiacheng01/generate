package com.hong.generate.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @description:
 * @author: YJH
 * @time: 2020/4/4 19:40
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Bean
    public Docket createRestApi() {

        ApiInfo apiInfo = new ApiInfoBuilder()
                .title("后台接口")
                .description("这是我第一个springboot接口")
                .contact(new Contact("Liuyanmin", "xxxx", "1354654@163.com"))
                .termsOfServiceUrl("http://localhost:60000/")
                .version("1.0")
                .build();

        return new Docket(DocumentationType.SWAGGER_2)
                .host("http://localhost:60000/")
                .groupName("后台接口")
                .apiInfo(apiInfo)
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.digitfacory.springbootdemo.controller"))
                .paths(PathSelectors.any())
                .build();
    }


}
