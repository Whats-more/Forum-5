package com.chen.springboot.service.impl;

import com.chen.springboot.entity.Comment;
import com.chen.springboot.mapper.CommentMapper;
import com.chen.springboot.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author GoatCode
 * @since 2024-03-22
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Resource
    private CommentMapper commentMapper;

    @Override
    public List<Comment> findCommentDetail(Integer articlesId) {

        return commentMapper.findCommentDetail(articlesId);
    }


}
