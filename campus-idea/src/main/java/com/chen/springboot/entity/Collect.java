package com.chen.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
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
 * @since 2024-02-09
 */
@Getter
@Setter
  @TableName("t_collect")
@ApiModel(value = "Collect对象", description = "")
public class Collect implements Serializable {

    private static final long serialVersionUID = 1L;

      @ApiModelProperty("ID")
        @TableId(value = "id", type = IdType.AUTO)
      private Long id;

      @ApiModelProperty("文章标题")
      private String title;

      @ApiModelProperty("链接")
      private String url;

      @ApiModelProperty("用户id")
      private Integer userId;

      @ApiModelProperty("收藏人")
      private String username;

      @ApiModelProperty("收藏时间")
      private String time;



}
