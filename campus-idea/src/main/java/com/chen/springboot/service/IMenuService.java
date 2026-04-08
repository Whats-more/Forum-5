package com.chen.springboot.service;

import com.chen.springboot.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-10
 */
public interface IMenuService extends IService<Menu> {

    List<Menu> findMenus(String name);
}
