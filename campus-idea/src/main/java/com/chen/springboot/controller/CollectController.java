package com.chen.springboot.controller;




import cn.hutool.core.date.DateUtil;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;


import com.chen.springboot.common.Result;


import com.chen.springboot.entity.User;
import com.chen.springboot.mapper.CollectMapper;
import com.chen.springboot.service.IUserService;
import com.chen.springboot.utils.TokenUtils;

import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import com.chen.springboot.service.ICollectService;
import com.chen.springboot.entity.Collect;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-09
 */
@RestController
@RequestMapping("/collect")
public class CollectController {

    @Resource
    private ICollectService collectService;
    private CollectMapper collectMapper;

    @Resource
    private IUserService userService;



    // 添加新的收藏
    @PostMapping
    public Result save(@RequestBody Collect collect) {
        QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
        List<Collect> list = collectService.list(queryWrapper);

        collect.setUserId(TokenUtils.getCurrentUser().getId());//填入当前登录用户的id  ，根据登录用户id来显示收藏标题


        User byId = userService.getById(TokenUtils.getCurrentUser().getId());

        collect.setUsername(byId.getUsername());
        collect.setTime(DateUtil.now());  // new Date() 获取当前收藏时间
        return Result.success(collectService.save(collect));
    }


    //删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        collectService.removeById(id);
        return Result.success();
    }

    //删除所有
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        collectService.removeByIds(ids);
        return Result.success();
    }

    //查询所有
    @GetMapping
    public Result findAll() {
        return Result.success(collectService.list());
    }

    //按照id查找
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(collectService.getById(id));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam(defaultValue = "") String title,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           HttpServletRequest request) {
        // 获取当前用户
        User currentUser = TokenUtils.getCurrentUser();
        if (currentUser == null) {
            return Result.error("401", "未登录");
        }

        QueryWrapper<Collect> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");

        // 如果不是管理员，只能查看自己的收藏
        if (!"ROLE_ADMIN".equals(currentUser.getRole())) {
            queryWrapper.eq("user_id", currentUser.getId());
        }

        if (StrUtil.isNotBlank(title)) {
            queryWrapper.like("title", title);
        }

        return Result.success(collectService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }




}

