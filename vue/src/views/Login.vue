<template>
  <div class="wrapper">
    <!-- 新增：右上角返回按钮 -->
    <div class="back-btn-container">
      <el-button 
        class="back-btn" 
        type="text" 
        @click="$router.push('/front/home')"
      >
        返回首页
      </el-button>
    </div>

    <div style="width: 30%; position: fixed; top: 20px; left: 20px; background-color: white; border-radius: 10px; display: flex;">
      <div style="flex: 1; padding: 30px">

        <transition appear name="fade-up" class="a1">
          <div style="margin:20px auto 25px; text-align: center; font-size: 28px;">
            <b>登 录</b>
          </div>
        </transition>

        <el-form :model="user" :rules="rules" ref="userForm">
          <transition appear name="fade-up" class="a2">
            <el-form-item prop="username" style="margin-top: 25px">
              <el-input placeholder="请输入账号" size="medium" prefix-icon="el-icon-user" v-model="user.username"></el-input>
            </el-form-item>
          </transition>

          <transition appear name="fade-up" class="a3">
            <el-form-item prop="password" style="margin-top: 15px">
              <el-input placeholder="请输入密码" size="medium" prefix-icon="el-icon-lock" show-password v-model="user.password"></el-input>
            </el-form-item>
          </transition>

          <transition appear name="fade-up" class="a4">
            <el-form-item style="margin: 30px 0; text-align: right">
              <el-button style="background:#EE707D;color:white; " size="medium" @click="$router.push('/register')">注册</el-button>
              <el-button style="background:#FE9859;color:white; " size="medium" @click="login">登录</el-button>
            </el-form-item>
          </transition>
        </el-form>

      </div>
    </div>
  </div>
</template>

<script>
import { setRoutes } from "@/router";
import imgUrl from "../assets/imgs/login.png";

export default {
  name: "Login",
  data() {
    return {
      user: { username: '', password: '' },
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
      },
      imgUrl: imgUrl
    }
  },
  methods: {
    login() {
      this.$refs['userForm'].validate((valid) => {
        if (valid) {  // 表单校验合法
          this.request.post("/user/login", this.user).then(res => {
            if (res.code === '200') {
              localStorage.setItem("user", JSON.stringify(res.data))  // 存储用户信息到浏览器
              localStorage.setItem("menus", JSON.stringify(res.data.menus))  // 存储用户信息到浏览器
              // 动态设置当前用户的路由
              setRoutes()
              this.$message.success("登录成功")

              if (res.data.role === 'ROLE_USER') {  //是用户的话，push到前台
                this.$router.push("/front/home")
              } else {
                this.$router.push("/")
              }
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      });
    }
  }
};
</script>

<style scoped>
/* 正常不加粗的思源黑体 */
@font-face {
  font-family: "思源黑体";
  src: url("../assets/fonts/思源黑体.ttf") format("truetype");
  font-weight: 400;    /* 正常不加粗 */
  font-style: normal;
}

/* 全局应用，并且强制不加粗 */
.wrapper,
.wrapper div,
.wrapper input,
.wrapper button,
.wrapper ::placeholder {
  font-family: "思源黑体" !important;
  font-weight: 400 !important;  /* 去掉加粗 */
}

/* 登录标题如果也不想加粗，就加这个 */
.wrapper b {
  font-weight: 400 !important;
}

.fade-up-enter-active {
  transition: all 1.0s ease !important;
}
.fade-up-enter {
  opacity: 0 !important;
  transform: translateY(30px) !important;
}

.a1 >>> .fade-up-enter-active { transition-delay: 0s !important; }
.a2 >>> .fade-up-enter-active { transition-delay: 0.1s !important; }
.a3 >>> .fade-up-enter-active { transition-delay: 0.2s !important; }
.a4 >>> .fade-up-enter-active { transition-delay: 0.3s !important; }

/* 登录页背景样式 */
.wrapper {  
  height: 100vh;  
  background: url('../assets/imgs/login.png');  
  background-size: cover; /* 图片完整显示，不裁剪 */
  background-position: bottom; /* 左下贴边 */
  background-repeat: no-repeat;  
  overflow: hidden;  
  position: relative; /* 新增：为按钮定位做父级参考 */
}

/* 新增：返回按钮容器 - 固定右上角 */
.back-btn-container {
  position: fixed;
  top: 20px;
  right: 20px;
  z-index: 999; /* 确保按钮在最上层 */
}

/* 新增：返回按钮样式 - 白底黑字半透明 */
.back-btn {
  background-color: rgba(255, 255, 255, 0.8) !important; /* 白底80%透明度 */
  color: #000 !important; /* 黑字 */
  border-radius: 8px !important;
  padding: 8px 16px !important;
  font-size: 14px !important;
  cursor: pointer;
}

/* 新增：按钮hover效果 */
.back-btn:hover {
  background-color: rgba(255, 255, 255, 1) !important; /* hover时完全不透明 */
  color: #333 !important;
}
</style>
