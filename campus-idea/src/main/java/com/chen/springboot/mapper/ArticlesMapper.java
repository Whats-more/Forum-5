package com.chen.springboot.mapper;

import com.chen.springboot.entity.Articles;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-04
 */
public interface ArticlesMapper extends BaseMapper<Articles> {


//    @Select("select * from t_articles  order by read_count desc")   //按照阅读数降序查询
//
//    }
//
//    @Select("select * from t_articles  order by good_count desc")
//    static  //按照点赞数降序排序
//    List<Articles> selectGoodDesc() {
//        return null;
//    }
//
//    @Select("select * from t_articles  order by time desc")
//    static   //按照发布时间降序排序，得到最新发布的文章
//    List<Articles> selectDateDesc() {
//        return null;
//    }
}
