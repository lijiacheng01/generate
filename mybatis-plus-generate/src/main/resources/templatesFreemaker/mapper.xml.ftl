<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

    <#if baseResultMap>
        <!-- 通用查询映射结果 -->
        <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
            <#list table.fields as field>
                <#if field.keyFlag><#--生成主键排在第一位-->
                    <id column="${field.name}" property="${field.propertyName}" />
                </#if>
            </#list>
            <#list table.commonFields as field><#--生成公共字段 -->
                <result column="${field.name}" property="${field.propertyName}" />
            </#list>
            <#list table.fields as field>
                <#if !field.keyFlag><#--生成普通字段 -->
                    <result column="${field.name}" property="${field.propertyName}" />
                </#if>
            </#list>
        </resultMap>

    </#if>
    <#if baseColumnList>
        <!-- 表名 -->
        <sql id="tb">${table.name}</sql>

        <!-- 通用查询结果列 -->
        <sql id="cols">
            <#list table.fields as field>
                <#if field_has_next>
                    ${field.name},
                <#else>
                    ${field.name}
                </#if>
            </#list>
        </sql>

        <sql id="vals">
            <#list table.fields as field>
                <#if field_has_next>
                    ${r"#{"}${field.propertyName}${r"}"},
                <#else>
                    ${r"#{"}${field.propertyName}${r"}"}
                </#if>
            </#list>
        </sql>
    </#if>

    <!-- 通用主键查询 -->
    <select id="loadByStr" parameterType="String" resultMap="BaseResultMap">
        select <include refid="cols"/>
        from <include refid="tb"/>
        <#list table.fields as field>
            <#if field.keyFlag>
                where ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
            </#if>
        </#list>
    </select>

    <!-- 通用条件查询列表 -->
    <select id="list" parameterType="${package.Entity}.${entity}" resultMap="BaseResultMap">
        select <include refid="cols"/>
        from <include refid="tb"/>
        where 1=1
        <#list table.fields as field>
            <if test="${field.propertyName} != null"> and ${field.name} = ${r"#{"}${field.propertyName}${r"}"} </if>
        </#list>
    </select>

    <!-- 通用全量插入 -->
    <insert id="create" parameterType="${package.Entity}.${entity}" >
        insert into <include refid="tb"/>
        ( <include refid="cols"/> )
        values ( <include refid="vals"/> )
    </insert>

    <!-- 通用全量插入，忽略null值 -->
    <insert id="createIgnoreNull" parameterType="${package.Entity}.${entity}">
        insert into <include refid="tb"/>
        <trim prefix="(" suffix=")" suffixOverrides=",">
            <#list table.fields as field>
                <if test="${field.propertyName} != null"> ${field.name}, </if>
            </#list>
        </trim>
        <trim prefix="values (" suffix=")" suffixOverrides=",">
            <#list table.fields as field>
                <if test="${field.propertyName} != null"> ${r"#{"}${field.propertyName}${r"}"}, </if>
            </#list>
        </trim>
    </insert>


    <!-- 通用根据主键更新 -->
    <update id="update" parameterType="${package.Entity}.${entity}" >
        update <include refid="tb"/> set
        <#list table.fields as field>
            <#if field_has_next>
                <#if !field.keyFlag>
                    ${field.name} = ${r"#{"}${field.propertyName}${r"}"},
                </#if>
            <#else>
                ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
            </#if>
        </#list>
        <#list table.fields as field>
            <#if field.keyFlag>
                where ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
            </#if>
        </#list>
    </update>

    <!-- 通用根据主键更新，忽略null值 -->
    <update id="updateIgnoreNull" parameterType="${package.Entity}.${entity}" >
        update <include refid="tb"/>
        <set>
            <#list table.fields as field>
                <#if !field.keyFlag>
                    <if test="${field.propertyName} != null"> ${field.name} = ${r"#{"}${field.propertyName}${r"}"}, </if>
                </#if>
            </#list>
        </set>
        <#list table.fields as field>
            <#if field.keyFlag>
                where ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
            </#if>
        </#list>
    </update>
</mapper>
