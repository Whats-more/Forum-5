<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="title"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>
<!--新增和批量删除-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm
          class="ml-5"
          confirm-button-text='确定'
          cancel-button-text='我再想想'
          icon="el-icon-info"
          icon-color="red"
          title="您确定批量删除这些数据吗？"
          @confirm="delBatch"
      >
        <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
      </el-popconfirm>

    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="70" sortable></el-table-column>
      <el-table-column prop="title" label="文章标题" width="120" ></el-table-column>
      <el-table-column prop="content" label="文章内容">
        <template slot-scope="scope">
          <el-button @click="view(scope.row.content)" type="primary">查看内容</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="cover" label="封面" width="150">
        <template slot-scope="scope" ><el-image style="width: 100px; height: 100px" :src="scope.row.cover" :preview-src-list="[scope.row.cover]"></el-image></template>
      </el-table-column>
      <el-table-column prop="username" label="发布人"></el-table-column>
      <el-table-column prop="time" label="发布时间"></el-table-column>
      <el-table-column prop="talk" label="话题"></el-table-column>

      <el-table-column prop="category" label="文章分类"></el-table-column>
      <el-table-column prop="readCount" label="阅读次数"></el-table-column>
      <el-table-column prop="goodCount" label="赞点数"></el-table-column>

      <el-table-column label="操作"  width="180" align="center">
        <template slot-scope="scope">
          <el-button type="success" @click="handleEdit(scope.row)">编辑 <i class="el-icon-edit"></i></el-button>
          <el-popconfirm
              class="ml-5"
              confirm-button-text='确定'
              cancel-button-text='我再想想'
              icon="el-icon-info"
              icon-color="red"
              title="您确定删除吗？"
              @confirm="del(scope.row.id)"
          >
            <el-button type="danger" slot="reference">删除 <i class="el-icon-remove-outline"></i></el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="padding: 10px 0">
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

<!--    新增和编辑的弹窗-->
    <el-dialog title="信息" :visible.sync="dialogFormVisible" width="60%" :close-on-click-modal="false">
      <el-form label-width="120px" size="small" style="width: 90%;" :model="form" :rules="rules" ref="ruleForm">
        <el-form-item prop="title" label="文章标题：">
          <el-input v-model="form.title" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="分类">
          <el-select clearable v-model="form.category" placeholder="请选择分类" style="width: 100%">
            <el-option v-for="item in category" :key="item.name" :label="item.name" :value="item.name"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item prop="cover" label="封面：">
        <el-upload action="http://localhost:9090/file/upload" ref="img" :on-success="handleImgUploadSuccess">
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item>


        <el-form-item prop="content" label="文章内容：">
          <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd"/>
        </el-form-item>

<!--        <el-form-item prop="talk" label="话题">-->
<!--          <el-input v-model="form.talk" autocomplete="off"></el-input>-->
<!--        </el-form-item>-->

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

<!--文章内容-->
    <el-dialog title="文章信息" :visible.sync="viewDialogVis" width="60%" >
      <el-card>
        <div>
          <mavon-editor
                  class="md"
                  :value="content"
                  :subfield="false"
                  :defaultOpen="'preview'"
                  :toolbarsFlag="false"
                  :editable="false"
                  :scrollStyle="false"
                  :ishljs="true"
          />
        </div>
      </el-card>
    </el-dialog>
  </div>
</template>

<script>
  import axios from "axios";

export default {
  name: "Articles",
  data() {
    return {
      tableData: [],
      category:[],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      title: '',
      form: {},
      dialogFormVisible: false,
      multipleSelection: [],
      username: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}, //获取登入人的username
      rules: {        //添加的规则 ，设定必填选项
        title: [
          { required: true, message: '请输入文章标题', trigger: 'blur'}
        ],
      },
      content: '',
      viewDialogVis: false
    }
  },
  created() {
    this.load()
  },
  methods: {
    view(content) {   //查看文章内容
      this.content = content
      this.viewDialogVis = true
    },
    // 绑定@imgAdd event
    imgAdd(pos, $file) {
      let $vm = this.$refs.md
      // 第一步.将图片上传到服务器.
      const formData = new FormData();
      formData.append('file', $file);
      axios({
        url: 'http://localhost:9090/file/upload',
        method: 'post',
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
      }).then((res) => {
        // 第二步.将返回的url替换到文本原位置![...](./0) -> ![...](url)
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
        this.tableData = res.data.records
        this.total = res.data.total
      })

      this.request.get("/category").then(res => {
        this.category = res.data
      })
    },
    save() {
        this.$refs['ruleForm'].validate((valid) => {
          if (valid) {
            this.request.post("/articles", this.form).then(res => {
              if (res.code === '200') {
                this.$message.success("保存成功")
                this.dialogFormVisible = false
                this.load()
              } else {
                this.$message.error(res.msg)
              }
            })
          }
        })
    },
    handleAdd() {
      this.dialogFormVisible = true
      this.form = {}
      this.$nextTick(() => {
        if(this.$refs.img) {
           this.$refs.img.clearFiles();
         }
         if(this.$refs.file) {
          this.$refs.file.clearFiles();
         }
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogFormVisible = true
       this.$nextTick(() => {
         if(this.$refs.img) {
           this.$refs.img.clearFiles();
         }
         if(this.$refs.file) {
          this.$refs.file.clearFiles();
         }
       })
    },
    del(id) {
      this.request.delete("/articles/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.load()
        } else {
          this.$message.error("删除失败")
        }
      })
    },
    handleSelectionChange(val) { //多选
      console.log(val)
      this.multipleSelection = val
    },
    //批量删除
    delBatch() {
      if (!this.multipleSelection.length) {
        this.$message.error("请选择需要删除的数据")
        return
      }
      let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
      this.request.post("/articles/del/batch", ids).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.load()
        } else {
          this.$message.error("批量删除失败")
        }
      })
    },

    reset() {
      this.title = ''
      this.load()
    },
    handleSizeChange(pageSize) {
      console.log(pageSize)
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      console.log(pageNum)
      this.pageNum = pageNum
      this.load()
    },
    handleFileUploadSuccess(res) {
      this.form.file = res
    },
    handleImgUploadSuccess(res) {
      this.form.cover = res
    },

  }
}
</script>


<style>
.headerBg {
  background: #02C39A !important;
}
</style>
