package com.chen.springboot.service;

import com.chen.springboot.entity.Comment;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author GoatCode
 * @since 2024-03-22
 */
public interface ICommentService extends IService<Comment> {

    //通过文章id来，查找评论详情
    List<Comment> findCommentDetail(Integer articlesId);

}
