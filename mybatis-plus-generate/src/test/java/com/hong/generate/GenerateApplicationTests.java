package com.hong.generate;

import com.hong.generate.mybatisplus.GenerateMybatisPlus;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource("classpath:generate.properties")
class GenerateApplicationTests {

    @Value("${datasource.url}")
    private String dataSourceurl;

    @Value("${datasource.username}")
    private String dataSourcename;

    @Value("${datasource.password}")
    private String dataSourcepassword;

    @Value("${datasource.driver-class-name}")
    private String dataSourcedriver;

    @Value("${datatables.name}")
    private String tables;

    @Value("${package.parent}")
    private String packageParent;

    @Value("${datatables.isNormalize}")
    private boolean isNormalize;

    @Value("${projectPath}")
    private String projectPath;

    @Value("${projectName}")
    private String projectName;

    @Value("${author}")
    private String author;

    @Test
    void generateMybatisPlusTest() {
        new GenerateMybatisPlus().generate(
                projectName,
                projectPath,
                author,
                dataSourceurl,
                dataSourcename,
                dataSourcepassword,
                dataSourcedriver,
                tables,
                packageParent,
                isNormalize);
    }

}
