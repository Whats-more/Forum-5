package com.chen.springboot.mapper;

import com.chen.springboot.entity.Comment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author GoatCode
 * @since 2024-03-22
 */
public interface CommentMapper extends BaseMapper<Comment> {

    //通过user_id 查出用户的头像和昵称
    @Select("select c.*,u.nickname,u.avatar_url from t_comment c left join sys_user u on c.user_id = u.id " +
            "where c.articles_id = #{articlesId} order by id desc")
    List<Comment> findCommentDetail(@Param("articlesId") Integer articlesId);




}


