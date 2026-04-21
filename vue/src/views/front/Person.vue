<template>
  <el-card style="width: 550px;margin:20px auto">
    <el-form label-width="100px" size="small" class="person-form">
      <!-- 头像区域单独左对齐 -->
      <div class="avatar-wrapper">
        <el-upload
            class="avatar-uploader"
            :action="'http://' + serverIp +':9090/file/upload'"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
        >
          <img v-if="form.avatarUrl" :src="form.avatarUrl" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>

      <el-form-item label="用户名">
        <el-input v-model="form.username" disabled autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="昵称">
        <el-input v-model="form.nickname" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="邮箱">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="电话">
        <el-input v-model="form.phone" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="地址">
        <el-input type="textarea" v-model="form.address" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item class="btn-item">
        <el-button type="primary" @click="save">确 定</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import {serverIp} from "../../../public/config";

export default {
  name: "Person",
  data() {
    return {
      serverIp: serverIp,
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.getUser().then(res => {
      console.log(res)
      this.form = res
    })
  },
  methods: {
    async getUser() {
      return (await this.request.get("/user/username/" + this.user.username)).data
    },
    save() {
      this.request.post("/user", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("保存成功")
          this.$emit("refreshUser")
          this.getUser().then(res => {
            res.token = JSON.parse(localStorage.getItem("user")).token
            localStorage.setItem("user", JSON.stringify(res))
          })
        } else {
          this.$message.error("保存失败")
        }
      })
    },
    handleAvatarSuccess(res) {
      this.form.avatarUrl = res
    }
  }
}
</script>

<style scoped>
/* 整体表单容器：左对齐 + 内边距 */
.person-form {
  padding: 20px 30px;
  text-align: left;
}

/* 头像区域：居中对齐 + 间距 */
.avatar-wrapper {
  margin-bottom: 30px;
  text-align: center; /* 只改了这里：居中 */
}

/* 整体容器：马卡龙浅蓝底 + 圆角卡片 */
:deep(.el-card) {
  border-radius: 20px !important;
  border: none !important;
  box-shadow: 0 6px 16px rgba(178, 216, 230, 0.15) !important;
  background-color: #f8fcff !important; /* 马卡龙浅蓝底 */
  overflow: hidden;
}

/* 头像样式优化 */
.avatar-uploader {
  display: inline-block;
}
.avatar-uploader .el-upload {
  border: 1px dashed #f0c8d2 !important; /* 马卡龙浅粉 */
  border-radius: 50% !important;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  background-color: #fff9fb; /* 极浅粉 */
  transition: all 0.3s ease;
}
.avatar-uploader .el-upload:hover {
  border-color: #b8e0d2 !important; /* 马卡龙浅绿 */
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(184, 224, 210, 0.2);
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #e8a8b8; /* 马卡龙粉 */
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}
.avatar {
  width: 138px;
  height: 138px;
  display: block;
  border-radius: 50% !important;
  object-fit: cover;
  box-shadow: 0 3px 10px rgba(178, 216, 230, 0.2); /* 马卡龙蓝阴影 */
}

/* 表单样式：增加标签与输入框间距 + 左对齐 */
:deep(.el-form-item) {
  margin-bottom: 25px !important; /* 表单项整体间距 */
  margin-left: 0 !important;
  text-align: left;
}

/* 标签样式：加大右侧间距 + 固定宽度 + 对齐 */
:deep(.el-form-item__label) {
  color: #7a9ba8 !important; /* 马卡龙深蓝灰 */
  font-size: 14px;
  font-weight: 50;
  padding-right: 15px !important; /* 标签与输入框的间距（核心优化） */
  text-align: right !important; /* 标签右对齐，输入框左对齐，视觉更规整 */
  line-height: 36px !important; /* 与输入框高度对齐 */
}

/* 输入框容器：加宽 + 间距优化 */
:deep(.el-form-item__content) {
  margin-left: 105px !important; /* 与label-width匹配，预留间距 */
}

/* 输入框：马卡龙蓝边框 + 粉聚焦 + 间距 */
:deep(.el-input__wrapper) {
  border-radius: 10px !important;
  border: 1px solid #ddeef5 !important; /* 马卡龙浅蓝 */
  background-color: #ffffff !important;
  box-shadow: none !important;
  transition: all 0.2s ease;
  height: 36px !important;
  padding: 0 15px !important; /* 输入框内边距，文字不贴边 */
}
:deep(.el-input__wrapper:focus-within) {
  border-color: #f0a8b8 !important; /* 马卡龙粉 */
  box-shadow: 0 0 0 2px rgba(240, 168, 184, 0.1) !important;
}
:deep(.el-input.is-disabled .el-input__wrapper) {
  background-color: #f5fafe !important; /* 极浅蓝 */
  border-color: #e8f4f8 !important;
  color: #8a9ea8 !important;
}

/* 文本域：加高 + 间距 */
:deep(.el-textarea__inner) {
  border-radius: 10px !important;
  border: 1px solid #ddeef5 !important; /* 马卡龙浅蓝 */
  background-color: #ffffff !important;
  resize: none !important;
  padding: 10px 15px !important; /* 内边距 */
  line-height: 1.5 !important;
}
:deep(.el-textarea__inner:focus) {
  border-color: #b8e0d2 !important; /* 马卡龙绿 */
  box-shadow: 0 0 0 2px rgba(184, 224, 210, 0.1) !important;
}

/* 按钮：左对齐 + 马卡龙蓝绿渐变 */
.btn-item {
  margin-left: 105px !important; /* 与输入框对齐 */
}
:deep(.el-button--primary) {
  background: linear-gradient(90deg, #a8d1e7 0%, #b8e0d2 100%) !important; /* 蓝绿渐变 */
  border-color: transparent !important;
  border-radius: 10px !important;
  padding: 8px 30px !important;
  font-size: 14px !important;
  color: #3a5a66 !important; /* 深灰蓝 */
  font-weight: 50;
  transition: all 0.3s ease;
}
:deep(.el-button--primary:hover) {
  background: linear-gradient(90deg, #98c1d7 0%, #a8d0c2 100%) !important;
  box-shadow: 0 4px 12px rgba(240, 168, 184, 0.15); /* 粉调阴影 */
  transform: translateY(-1px);
}
</style>