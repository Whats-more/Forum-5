<template>
  <div>
    <!--回到顶部轮子-->
    <vueToTop type="4" size="50" right="45" bottom="45" color="#778CCD"></vueToTop>

    <div style="display: flex;gap: 20px;padding: 20px;min-height: 100vh;">

      <!--左侧内容区-->
      <div style="background-color: white;border-radius: 12px;width: 754px;overflow: hidden;box-shadow: 0 2px 8px rgba(0,0,0,0.05)" class="container-height">

        <!--搜索栏-->
        <div style="margin: 15px 20px">
          <el-input size="small" style="width: 300px" placeholder="请输入要搜索文章的标题" suffix-icon="el-icon-search" v-model="title"></el-input>
          <el-button class="ml-5" type="primary" @click="load" size="small">搜索</el-button>
          <el-button type="warning" @click="reset" size="small">重置</el-button>
        </div>

        <!--帖子列表-->
        <div style="padding: 10px" v-for="item in articleData" :key="item.id">
          <el-card shadow="hover">
            <div>
              <!--头像昵称-->
              <div style="display: flex;align-items: center;">
                <div style="width: 60px">
                  <img style="width: 50px; height: 50px; border-radius: 50%;object-fit:cover" :src="item.userAvatar" alt="">
                </div>
                <div style="flex: 1; line-height: 24px">
                  <div style="font-weight: bold;color: #333">{{item.username}}</div>
                  <div style="font-size: 12px;color: #999">{{item.time}}</div>
                </div>
              </div>

              <!--标题内容-->
              <div style="margin: 12px 0;font-size: 14px;line-height: 26px;text-align: justify;cursor:pointer;color: #222"
                   class="content" @click="$router.push('/front/articlesDetail?id=' + item.id)">
                {{item.title}}
              </div>

              <!--封面图-->
              <div style="margin: 10px 0;">
                <el-row :gutter="10">
                  <el-col :span="10" style="margin: 5px 0">
                    <img style="width: 100%;height:120px;object-fit:cover;border-radius:8px" :src="item.cover" alt="">
                  </el-col>
                </el-row>
              </div>

              <!--标签 + 互动数据-->
              <div style="margin: 10px 0; display: flex;align-items:center">
                <div style="width: 50%">
                  <el-tag type="primary">#{{item.category}}</el-tag>
                  <el-tag type="primary" style="margin-left: 8px">#话题</el-tag>
                </div>
                <div style="width: 50%;color: #666;font-size: 13px; text-align: right">
                  <img style="width: 18px;vertical-align:middle;margin-right:4px" :src="icon[2]" alt="">
                  {{ item.readCount }}
                  <img style="width: 18px;vertical-align:middle;margin:0 4px" :src="icon[0]" alt="">
                  {{ item.goodCount }}
                  <img style="width: 18px;vertical-align:middle;margin-left:4px" :src="icon[1]" alt="">
                </div>
              </div>
            </div>
          </el-card>
        </div>

        <!--分页-->
        <div style="padding: 15px 20px;text-align:right">
          <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="pageNum"
            :page-sizes="[2, 5, 10, 20]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
          </el-pagination>
        </div>
      </div>

      <!--右侧栏-->
      <div style="width: 300px;display:flex;flex-direction:column;gap:12px">
        <!--发帖按钮-->
        <el-card>
          <el-button type="primary" round style="width: 100%;font-weight:bold" @click="handleAdd">发表文章</el-button>
        </el-card>

        <!--点赞榜单-->
        <el-card>
          <div style="padding: 12px">
            <div style="padding: 8px 0;border-bottom: 2px solid #FAD252; font-size: 16px;font-weight:bold;color:#333">
              最受欢迎帖子榜单
            </div>
            <div style="margin-top:12px">
              <div style="padding: 10px 0;border-bottom: 1px dashed #B5E2E7" v-for="item in tableDataGood" :key="item.id">
                <a style="color:#778CCD" @click="$router.push('/front/articlesDetail?id=' + item.id)">{{item.title}}</a>
              </div>
            </div>
          </div>
        </el-card>

        <!--浏览榜单-->
        <el-card>
          <div style="padding: 12px">
            <div style="padding: 8px 0;border-bottom: 2px solid #FB8B63; font-size: 16px;font-weight:bold;color:#333">
              帖子浏览量榜单
            </div>
            <div style="margin-top:12px">
              <div style="padding: 10px 0;border-bottom: 1px dashed #FBAEAB" v-for="item in tableDataRead" :key="item.id">
                <a style="color:#778CCD" @click="$router.push('/front/articlesDetail?id=' + item.id)">{{item.title}}</a>
              </div>
            </div>
          </div>
        </el-card>
      </div>

    </div>

    <!--新增编辑弹窗-->
    <el-dialog title="文章信息" :visible.sync="dialogFormVisible" width="60%" :close-on-click-modal="false">
      <el-form label-width="120px" size="small" style="width: 90%;" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item prop="title" label="文章标题：">
          <el-input v-model="form.title" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="文章分类：">
          <el-select clearable v-model="form.category" placeholder="请选择分类" style="width: 100%">
            <el-option v-for="item in category" :key="item.name" :label="item.name" :value="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="cover" label="文章封面：">
          <el-upload action="http://localhost:9090/file/upload" ref="img" :on-success="handleImgUploadSuccess">
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="content" label="文章内容：">
          <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import icon_good from "../../assets/imgs/icons8-thumbs-up-65.png";
import icon_comment from "../../assets/imgs/icons8-comments-48.png";
import icon_view from "../../assets/imgs/icons8-eye-48.png";
import icon_top from "../../assets/imgs/icons8-collapse-arrow-50.png";
import axios from "axios";

export default {
  name: "Forum",
  data() {
    return {
      icon: [icon_good, icon_comment, icon_view, icon_top],
      form: {},
      articleData: [],
      category: [],
      title: '',
      content: '',
      multipleSelection: [],
      pageNum: 1,
      pageSize: 10,
      total: 0,
      tableDataGood: [],
      tableDataRead: [],
      dialogFormVisible: false,
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      viewDialogVis: false,
      rules: {
        title: [
          { required: true, message: '请输入文章标题', trigger: 'blur' }
        ],
      },
      showBtn: false,
    }
  },
  created() {
    this.load()
  },
  mounted() {
    window.addEventListener("scroll", this.showbtn, true);
  },
  methods: {
    view(content) {
      this.content = content
      this.viewDialogVis = true
    },
    imgAdd(pos, $file) {
      let $vm = this.$refs.md
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: 'http://localhost:9090/file/upload',
        method: 'post',
        data: formData,
        headers: { 'Content-Type': 'multipart/form-data' },
      }).then((res) => {
        $vm.$img2Url(pos, res.data);
      })
    },
    load() {
      this.request.get("/articles/page", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          title: this.title,
        }
      }).then(res => {
        this.articleData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/articles/read", {
        params: { pageNum: this.pageNum, pageSize: this.pageSize }
      }).then(res => {
        this.tableDataRead = res.data.records
      })

      this.request.get("/articles/good", {
        params: { pageNum: this.pageNum, pageSize: this.pageSize }
      }).then(res => {
        this.tableDataGood = res.data.records
      })

      this.request.get("/category").then(res => {
        this.category = res.data
      })
    },
    changeEnable(row) {
      this.request.post("/articles/update", row).then(res => {
        if (res.code === '200') this.$message.success("操作成功")
      })
    },
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
      this.$nextTick(() => {
        if (this.$refs.img) this.$refs.img.clearFiles();
        if (this.$refs.file) this.$refs.file.clearFiles();
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
    },
    del(id) {
      this.request.delete("/articles/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.load()
        } else this.$message.error("删除失败")
      })
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    delBatch() {
      let ids = this.multipleSelection.map(v => v.id)
      this.request.post("/articles/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.load()
        } else this.$message.error("批量删除失败")
      })
    },
    save() {
      this.request.post("/articles", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")
          this.dialogFormVisible = false
          this.load()
        } else this.$message.error("保存失败")
      })
    },
    reset() {
      this.title = ""
      this.load()
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.load()
    },
    download(url) {
      window.open(url)
    },
    handleImgUploadSuccess(res) {
      this.form.cover = res
    },
  }
}
</script>

<style scoped>
/* 文本溢出省略 */
.content {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
}

/* 主色：#778CCD */
:deep(.el-button--primary) {
  background-color: #778CCD !important;
  border-color: #778CCD !important;
  color: #fff !important;
}
:deep(.el-button--primary:hover) {
  background-color: #6674b3 !important;
  border-color: #6674b3 !important;
}

/* 重置按钮：#FB8B63 */
:deep(.el-button--warning) {
  background-color: #FB8B63 !important;
  border-color: #FB8B63 !important;
  color: #fff !important;
}
:deep(.el-button--warning:hover) {
  background-color: #e67a55 !important;
  border-color: #e67a55 !important;
}

/* 标签：#B5E2E7 */
:deep(.el-tag--primary) {
  background-color: #B5E2E7 !important;
  border-color: #B5E2E7 !important;
  color: #333 !important;
}

/* 分页 */
:deep(.el-pagination .el-pager li.is-active) {
  background-color: #778CCD !important;
  border-color: #778CCD !important;
  color: #fff !important;
}
:deep(.el-pagination button:hover),
:deep(.el-pagination .el-pager li:hover) {
  color: #778CCD !important;
  border-color: #B5E2E7 !important;
}

/* 卡片样式 */
:deep(.el-card) {
  border: 1px solid #f0f7ff !important;
  border-radius: 10px !important;
}
</style>