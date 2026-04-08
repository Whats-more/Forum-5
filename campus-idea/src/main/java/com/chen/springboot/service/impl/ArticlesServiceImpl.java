package com.chen.springboot.service.impl;

import com.chen.springboot.entity.Articles;
import com.chen.springboot.mapper.ArticlesMapper;
import com.chen.springboot.service.IArticlesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-04
 */
@Service
public class ArticlesServiceImpl extends ServiceImpl<ArticlesMapper, Articles> implements IArticlesService {



}
