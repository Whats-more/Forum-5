package com.chen.springboot.service.impl;

import com.chen.springboot.entity.Category;
import com.chen.springboot.mapper.CategoryMapper;
import com.chen.springboot.service.ICategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-10
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements ICategoryService {

}
