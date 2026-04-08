package com.chen.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
 * @since 2024-01-27
 */
@Getter
@Setter
  @ApiModel(value = "Lun对象", description = "")
public class Lun implements Serializable {

    private static final long serialVersionUID = 1L;

      @TableId(value = "id", type = IdType.AUTO)
      private Integer id;

      @ApiModelProperty("轮播图图片")
      private String img;

      @ApiModelProperty("轮播图点击后的章文连接")
      private String link;

      @ApiModelProperty("文章id")
      private Integer articleId;

      @ApiModelProperty("文章名")
      private String articleName;


}
