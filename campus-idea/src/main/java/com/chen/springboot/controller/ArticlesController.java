package com.chen.springboot.controller;


import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.chen.springboot.common.Result;

import com.chen.springboot.entity.Articles;


import com.chen.springboot.utils.TokenUtils;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import com.chen.springboot.service.IArticlesService;




import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-04
 */
@RestController
@RequestMapping("/articles")
public class
ArticlesController {

    @Resource
    private IArticlesService articlesService;

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody Articles articles) {
        if (articles.getId() == null) { // 新增
            articles.setTime(DateUtil.now());  // new Date()
            articles.setUsername(TokenUtils.getCurrentUser().getNickname());//填入当前登录用户的昵称
            articles.setUserAvatar(TokenUtils.getCurrentUser().getAvatarUrl()); //填入当前登录用户的头像
        }
        articlesService.saveOrUpdate(articles);
        return Result.success();
    }
    //删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        articlesService.removeById(id);
        return Result.success();
    }
    //批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        articlesService.removeByIds(ids);
        return Result.success();
    }
    //查询所有
    @GetMapping
    public Result findAll() {
        return Result.success(articlesService.list());
    }

    //通过id查询
    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(articlesService.getById(id));
    }


    //分页查询和按照文章名查询
    @GetMapping("/page")
    public Result findPage(@RequestParam (defaultValue = "") String title,
                           @RequestParam (defaultValue = "") String category,
                           @RequestParam Integer pageNum,
                           @RequestParam Integer pageSize) {
        QueryWrapper<Articles> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");  //按照id倒序排序

        if (StrUtil.isNotBlank(title)) {         // 标题模糊查询
            queryWrapper.like("title", title);
        }
        if (StrUtil.isNotBlank(category)) {         //分类模糊查询
            queryWrapper.like("category ", category);
        }
        return Result.success(articlesService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    //计算点赞数和阅读书
    @PutMapping ("/count")
    public Result count() {
        List<Articles> list = articlesService.list();

        Map<String, List<Articles>> collect = list.stream().collect(Collectors.groupingBy(Articles::getUsername));

        Map<String, Integer> goodCount = new HashMap<>();  //点赞
        Map<String, Integer> readCount = new HashMap<>();   //阅读

        for (Map.Entry<String, List<Articles>> entry : collect.entrySet()) {

            int praiseSum = entry.getValue().stream().mapToInt(Articles::getGoodCount).sum();
            int readSum = entry.getValue().stream().mapToInt(Articles::getReadCount).sum();

            goodCount.put(entry.getKey(), praiseSum);
            readCount.put(entry.getKey(), readSum);
        }
        Map<String, Object> res = new HashMap<>();
        res.put("goodCount",goodCount);
        res.put("readCount", readCount);
        return Result.success(res);
    }

    //按照阅读数、点赞数、和时间 降序排序  分页进行查询
    @GetMapping("/read")
    public Result findReadPage(
                        @RequestParam Integer pageNum,
                       @RequestParam Integer pageSize) {
        QueryWrapper<Articles> queryWrapperRead = new QueryWrapper<>();
        queryWrapperRead.orderByDesc("read_count");  //按照阅读数倒序排序

        return Result.success(articlesService.page(new Page<>(pageNum, pageSize), queryWrapperRead));
    }

    @GetMapping("/good")
    public Result findGoodPage(
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize) {
        QueryWrapper<Articles> queryWrapperGood = new QueryWrapper<>();
        queryWrapperGood.orderByDesc("good_count");  //按照点赞数倒序排序

        return Result.success(articlesService.page(new Page<>(pageNum, pageSize), queryWrapperGood));
    }

    @GetMapping("/date")
    public Result findDatePage(
            @RequestParam Integer pageNum,
            @RequestParam Integer pageSize) {

        QueryWrapper<Articles> queryWrapperTime = new QueryWrapper<>();
        queryWrapperTime.orderByDesc("time");  //按照发布时间倒序排序

        return Result.success(articlesService.page(new Page<>(pageNum, pageSize), queryWrapperTime));
    }


}

