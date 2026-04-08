package com.chen.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author GoatCode
 * @since 2024-02-04
 */
@Getter
@Setter
  @TableName("t_articles")
@ApiModel(value = "Articles对象", description = "")
public class Articles implements Serializable {

    private static final long serialVersionUID = 1L;

      @ApiModelProperty("ID")
        @TableId(value = "id", type = IdType.AUTO)
      private Long id;

      @ApiModelProperty("文章标题")
      private String title;

      @ApiModelProperty("文章内容")
      private String content;

      @ApiModelProperty("封面")
      private String cover;

      @ApiModelProperty("发布人")
      private String username;


      @ApiModelProperty("发布时间")
      private String time;

      @ApiModelProperty("话题")
      private String talk;

      @ApiModelProperty("文章分类")
      private String category;

      @ApiModelProperty("阅读次数")
      private Integer readCount;

      @ApiModelProperty("赞点数")
      private Integer goodCount;


      @ApiModelProperty("发布人头像")
      private String userAvatar;

}
