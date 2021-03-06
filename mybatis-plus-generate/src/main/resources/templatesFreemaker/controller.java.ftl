package ${package.Controller};



import ${package.Service}.${table.serviceName};
import ${package.Entity}.${entity};
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import java.util.List;
<#if restControllerStyle>
    import org.springframework.web.bind.annotation.RestController;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
    import ${superControllerClassPackage};
</#if>

/**
* <p>
    * ${table.comment!} 前端控制器
    * </p>
*
* @author ${author}
* @since ${date}
*/

@Slf4j
@RequiredArgsConstructor
@Api(tags = "${table.comment!}")
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName??>/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
<#if kotlin>
    class ${table.controllerName}<#if superControllerClass??> : ${superControllerClass}()</#if>
<#else>
    <#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
    <#else>
public class ${table.controllerName} {

    private final ${table.serviceName} ${table.entityPath}Service;

    @ApiOperation(value = "新增")
    @PostMapping("/save")
    public Response<${entity}> save(@RequestBody ${entity} ${table.entityPath}){
        ${table.entityPath}Service.save(${table.entityPath});
        return Response.success();
    }

    @ApiOperation(value = "根据id删除")
    @PostMapping("/delete/{id}")
    public Response<${entity}> delete(@PathVariable("id") Long id){
        ${table.entityPath}Service.removeById(id);
        return Response.success();
    }

    @ApiOperation(value = "条件查询")
    @PostMapping("/get")
    public AjaxResult list(@RequestBody ${entity} ${table.entityPath}){
        List<${entity}> ${table.entityPath}List = ${table.entityPath}Service.list(new QueryWrapper<>(${table.entityPath}));
        return AjaxResult.success(${table.entityPath}List);
    }

    @ApiOperation(value = "列表（分页）")
    @GetMapping("/list/{pageNum}/{pageSize}")
    public Response<PageResult<${entity}>> list(@PathVariable("pageNum")Long pageNum, @PathVariable("pageSize")Long pageSize){
        IPage<${entity}> page = ${table.entityPath}Service.page(
        new Page<>(pageNum, pageSize), null);
        return Response.success(new PageResult<${entity}>(page.getTotal(),page.getRecords()));

    }

    @ApiOperation(value = "详情")
    @GetMapping("/get/{id}")
    public Response<${entity}> get(@PathVariable("id") String id){
        ${entity} ${table.entityPath} = ${table.entityPath}Service.getById(id);
        return Response.success(${table.entityPath});
    }

    @ApiOperation(value = "根据id修改")
    @PostMapping("/update/{id}")
    public Response<${entity}> update(@PathVariable("id") Long id, @RequestBody ${entity} ${table.entityPath}){
        ${table.entityPath}.setId(id);
        ${table.entityPath}Service.updateById(${table.entityPath});
        return Response.success();
    }

    </#if>

}
</#if>
