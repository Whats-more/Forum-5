<template>
  <div>
    <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入文章标题" suffix-icon="el-icon-search" v-model="title"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div>

    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80" sortable></el-table-column>
      <el-table-column prop="title" label="文章标题"></el-table-column>
      <el-table-column prop="url" label="链接">
        <template slot-scope="scope">
          <el-link type="primary" :href="scope.row.url" target="_blank">查看链接</el-link>
        </template>
      </el-table-column>
      <el-table-column prop="username" label="收藏人"></el-table-column>
      <el-table-column prop="time" label="收藏时间"></el-table-column>

      <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
          <el-button type="danger" @click="del(scope.row.id)" v-if="user.role === 'ROLE_ADMIN'">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div style="padding: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-sizes="[5, 10, 20, 50]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  name: "CollectAdmin",
  data() {
    return {
      tableData: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      title: "",
      multipleSelection: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      // 如果是管理员，获取所有收藏记录
      const params = {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
        title: this.title
      }
      
      this.request.get("/collect/page", { params }).then(res => {
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    del(id) {
      this.$confirm('确定要删除这条收藏记录吗?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.request.delete("/collect/" + id).then(res => {
          if (res.code === '200') {
            this.$message.success("删除成功")
            this.load()
          } else {
            this.$message.error(res.msg)
          }
        })
      })
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
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
    }
  }
}
</script>

<style>
.headerBg {
  background: #eee!important;
}
</style>