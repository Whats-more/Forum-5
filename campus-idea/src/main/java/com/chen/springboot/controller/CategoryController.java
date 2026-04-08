package com.chen.springboot.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.chen.springboot.common.Result;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.springboot.service.ICategoryService;
import com.chen.springboot.entity.Category;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-10
 */
@RestController
@RequestMapping("/category")
public class CategoryController {

    @Resource
    private ICategoryService categoryService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Category category) {
        categoryService.saveOrUpdate(category);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        categoryService.removeById(id);
        return Result.success();
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        categoryService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result findAll() {
        return Result.success(categoryService.list());
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(categoryService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam (defaultValue = "") String name,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Category> queryWrapper = new QueryWrapper<>();
        if (StrUtil.isNotBlank(name)) {         //模糊查询
            queryWrapper.like("name", name);
        }

        queryWrapper.orderByDesc("id");
        return Result.success(categoryService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

