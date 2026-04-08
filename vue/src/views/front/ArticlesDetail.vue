<template>
  <div style="color: #666">

<!--文章标题 -->
    <div style="margin: 20px 0; ">
      <div class="pd-10" style="font-size: 25px; color: #3F5EFB; cursor: pointer">{{ articles.title }}</div>

<!--分享、收藏按钮-->
      <div style="text-align: right">

        <el-button size="mini" @click="vis = true"><i class="el-icon-position"></i></el-button>

        <el-button :class="{active: collectActive}" size="mini" @click="collect"><i class="el-icon-collection-tag"></i></el-button>
      </div>
<!--发布人，发布时间，阅读数-->
      <div style="height: 1px; margin: 5px 0; background-color: #ccc"></div>
      <div style="font-size: 14px; margin-top: 10px">
        <i class="el-icon-user-solid"></i> <span>{{ articles.username }}</span>
        <i class="el-icon-time" style="margin-left: 10px"></i> <span>{{ articles.time }}</span>
        <i style="margin-left: 15px"><img style="width: 14px" :src="icon[0]" alt="" ></i> <span style="font-size:14px">{{ articles.readCount }}</span>
      </div>
    </div>

<!--文章内容-->
   <div style="margin: 20px 0">
     <mavon-editor
         class="md"
         :value="articles.content"
         :subfield="false"
         :defaultOpen="'preview'"
         :toolbarsFlag="false"
         :editable="false"
         :scrollStyle="true"
         :ishljs="true"
     />
   </div>

<!-- 点赞-->

      <div style="border-top: 1px solid #ccc; margin-top: 20px; padding: 20px 0; text-align: center">


          <el-button type="danger" size="medium" @click="handlePraise">点赞({{articles.goodCount}})</el-button>


      </div>


<!--     评论输入框-->
    <div style="margin: 30px 0">
      <div style="margin: 10px 0">
        <div style="border-bottom: 1px solid orangered; padding: 10px 0; font-size: 20px">评论</div>
        <div style="padding: 10px 0">
          <el-input size="small" type="textarea" v-model="commentForm.content"></el-input>
        </div>
        <div class="pd-10" style="text-align: right">
          <el-button type="primary" size="small" @click="save">评论</el-button>
        </div>
      </div>

<!--      评论列表-->
      <div>
        <div v-for="item in comments" :key="item.id" style="border-bottom: 1px solid #ccc; padding: 10px 0; ">
          <div style="display: flex">
            <div style="width: 100px; text-align: center">
              <el-image :src="item.avatarUrl" style="width: 50px; height: 50px; border-radius: 50%"></el-image>
            </div> <!--  头像-->
            <div style="flex: 1; font-size: 14px; padding: 5px 0; line-height: 25px">
              <b>{{ item.nickname }}：</b>
              <span>{{ item.content }}</span>

              <div style="display: flex; line-height: 20px; margin-top: 5px">
                <div style="width: 200px;">
                  <i class="el-icon-time"></i><span style="margin-left: 5px">{{ item.time }}</span>
                </div>
                <div style="text-align: right; flex: 1">
                  <el-button style="margin-left: 5px" type="text" @click="handleReply(item.id)">回复</el-button>
                  <el-button type="text" style="color: red" @click="del(item.id)" v-if="user.id === item.userId">删除</el-button>
                </div>
              </div>
            </div>   <!--  内容-->
          </div>

          <div v-if="item.children.length"  style="padding-left: 200px;">
            <div v-for="subItem in item.children" :key="subItem.id"  style="background-color: #f0f0f0; padding: 5px 20px">
              <!--          回复列表-->
              <div style="font-size: 14px; padding: 5px 0; line-height: 25px">
                <div>
                  <b style="color: #3a8ee6" v-if="subItem.pnickname">@{{ subItem.pnickname }}</b>
                </div>
                <div style="padding-left: 5px">
                  <b>{{ subItem.nickname }}：</b>
                  <span>{{ subItem.content }}</span>
                </div>

                <div style="display: flex; line-height: 20px; margin-top: 5px; padding-left: 5px">
                  <div style="width: 200px;">
                    <i class="el-icon-time"></i><span style="margin-left: 5px">{{ subItem.time }}</span>
                  </div>
                  <div style="text-align: right; flex: 1">
                    <el-button style="margin-left: 5px" type="text" @click="handleReply(subItem.id)">回复</el-button>
                    <el-button type="text" style="color: red" @click="del(subItem.id)" v-if="user.id === subItem.userId">删除</el-button>
                  </div>
                </div>
              </div>   <!--  内容-->
            </div>

          </div>


        </div>
      </div>

    </div>


    <el-dialog title="回复" :visible.sync="dialogFormVisible" width="50%" >
      <el-form label-width="80px" size="small">
        <el-form-item label="回复内容">
          <el-input type="textarea" v-model="commentForm.contentReply" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="save"  size="small">确 定</el-button>
      </div>
    </el-dialog>

<!--分享-->
    <el-dialog title="分享" :visible.sync="vis" width="30%">
      <div>本文地址： <span style="color: blue">{{url}}</span></div>
    </el-dialog>
  </div>
</template>

<script>
  import icon_view from "../../assets/imgs/icons8-eye-48.png";
  import request from "@/utils/request";

  const id = location.href.split("=")[1];
export default {
  name: "Article",
  data() {
    return {
      articles: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},  //获取当前登入人的信息
      comments: [],
      commentForm: {},
      id: this.$route.query.id,
      dialogFormVisible:false,
      collectActive: false,  //收藏默认是关闭的
      vis: false,
      url:'http://localhost:8080/front/articlesDetail?id=35',
      icon:[icon_view],
      flag: false,

    }
  },
  created() {
    this.load()
    this.loadComment()

  },
  methods: {
    load() {
      this.request.get("/articles/" + this.id).then(res => {
        this.articles = res.data
          //阅读数加1
          this.articles.readCount += 1
          request.post("/articles/", this.articles)
      })
    },
    loadComment() {        //获取后端的数据
      this.request.get("/comment/tree/" + this.id).then(res => {
        console.log(res)
        this.comments = res.data
      })
    },

    save() {          //保存评论内容
      if (!this.user.id) {
        this.$message.warning("请登录后操作")
        return
      }
      this.commentForm.articlesId = this.id
      if (this.commentForm.contentReply) {
        this.commentForm.content = this.commentForm.contentReply
      }

      this.request.post("/comment", this.commentForm).then(res => {   //把值传到后台
        if (res.code === '200') {
          this.$message.success("评论成功")
          this.commentForm = {}  // 初始化评论对象内容
          this.loadComment()
          this.dialogFormVisible = false
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    del(id) {   //删除评论
      this.request.delete("/comment/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.loadComment()
        } else {
          this.$message.error("删除失败")
        }
      })
    },
    handleReply(pid) {    //评论回复
      this.commentForm = { pid: pid }
      this.dialogFormVisible = true
    },
    collect(content) {   //收藏
      request.post("/collect/", {userId: this.user.id, title: this.articles.title,url: this.articles.id,}).then(res => {
        if (res.code === '200') {
          this.$message({
            message: "收藏成功",
            type: "success"
          });
        }
      })
    },
    handlePraise(){  //点赞
        if(this.flag) {
            this.$message({
                message: "你已经点过赞了",
                type: "warning"
            });
        } else {
            this.flag = true
            this.articles.goodCount += 1
          request.post("/articles/", this.articles).then(res => {
                this.$message({
                    message: "点赞成功",
                    type: "success"
                });
            })
        }
    }
  }
}
</script>

<style scoped>

</style>
