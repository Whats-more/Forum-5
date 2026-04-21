<template>
  <div class="wrapper">
    <!-- 新增：右上角返回首页按钮 -->
    <div class="back-btn-container">
      <el-button 
        class="back-btn" 
        type="text" 
        @click="$router.push('/front/home')"
      >
        返回首页
      </el-button>
    </div>

    <div class="form-container">
      <transition appear name="fade-up" class="a1">
        <div style="margin:20px auto 25px; text-align: center; font-size: 28px;">
          <b>注 册</b>
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

        <transition appear name="fade-up" class="a3">
          <el-form-item prop="confirmPassword" style="margin-top: 15px">
            <el-input placeholder="请确认密码" size="medium" prefix-icon="el-icon-lock" show-password v-model="user.confirmPassword"></el-input>
          </el-form-item>
        </transition>

        <!-- 邮箱 -->
        <transition appear name="fade-up" class="a4">
          <el-form-item prop="email" style="margin-top: 15px">
            <el-input placeholder="请输入邮箱" size="medium" prefix-icon="el-icon-message" v-model="user.email"></el-input>
          </el-form-item>
        </transition>

        <!-- 验证码 + 青蓝色按钮 -->
        <transition appear name="fade-up" class="a4">
          <el-form-item prop="code" style="margin-top: 15px">
            <div style="display: flex; gap: 10px">
              <el-input placeholder="请输入验证码" size="medium" v-model="user.code" style="flex: 1"></el-input>
              <el-button 
                size="medium" 
                @click="sendCode" 
                :disabled="codeDisabled"
                class="code-btn"
              >
                {{ codeText }}
              </el-button>
            </div>
          </el-form-item>
        </transition>

        <transition appear name="fade-up" class="a4">
          <el-form-item style="margin: 30px 0; text-align: right">
            <el-button style="background:#EE707D;color:white; " size="medium" @click="register">注册</el-button>
            <el-button style="background:#FE9859;color:white; " size="medium" @click="$router.push('/login')">返回登录</el-button>
          </el-form-item>
        </transition>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        email: '',
        code: ''
      },
      codeDisabled: false,
      codeText: "发送验证码",
      timer: null,
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '请确认密码', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        email: [
          { required: true, message: '请输入邮箱', trigger: 'blur' },
          { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
        ],
        code: [
          { required: true, message: '请输入验证码', trigger: 'blur' },
          { min: 6, max: 6, message: '验证码必须是6位数字', trigger: 'blur' }
        ]
      },
    }
  },
  methods: {
    sendCode() {
      this.$refs.userForm.validateField('email', valid => {
        if (!valid) {
          this.request.post("/user/sendCode", { email: this.user.email }).then(res => {
            if (res.code === '200') {
              this.$message.success("验证码发送成功！");
              this.startCountDown();
            } else {
              this.$message.error(res.msg);
            }
          })
        }
      })
    },

    startCountDown() {
      let count = 60;
      this.codeDisabled = true;
      this.codeText = `${count}秒后重新发送`;

      this.timer = setInterval(() => {
        count--;
        this.codeText = `${count}秒后重新发送`;
        if (count <= 0) {
          clearInterval(this.timer);
          this.codeDisabled = false;
          this.codeText = "发送验证码";
        }
      }, 1000);
    },

    register() {
      this.$refs['userForm'].validate((valid) => {
        if (valid) {
          if (this.user.password !== this.user.confirmPassword) {
            this.$message.error("两次输入的密码不一致")
            return false
          }
          this.request.post("/user/register", this.user).then(res => {
            if(res.code === '200') {
              this.$message.success("注册成功")
              this.$router.push('/login')
            } else {
              this.$message.error(res.msg)
            }
          })
        }
      });
    }
  },
  beforeDestroy() {
    if (this.timer) clearInterval(this.timer);
  }
};
</script>

<style scoped>
@font-face {
  font-family: "思源黑体";
  src: url("../assets/fonts/思源黑体.ttf") format("truetype");
  font-weight: 400;
  font-style: normal;
}

.wrapper,
.wrapper div,
.wrapper input,
.wrapper button,
.wrapper ::placeholder {
  font-family: "思源黑体" !important;
  font-weight: 400 !important;
}

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

.form-container {
  width: 30%;
  position: fixed;
  top: -10px;
  left: 20px;
  padding: 30px;

  /* 等比例缩放核心代码 */
  transform: scale(0.90);
  transform-origin: left top;
}

.code-btn {
  background-color: #40c4ff !important;
  border-color: #40c4ff !important;
  color: white !important;
}
.code-btn:disabled {
  background-color: #b3e5fc !important;
  border-color: #b3e5fc !important;
}

/* 新增：返回按钮容器 - 固定右上角 */
.back-btn-container {
  position: fixed;
  top: 20px;
  right: 20px;
  z-index: 999; /* 确保按钮在最上层 */
}

/* 新增：返回按钮样式 - 白底黑字半透明，和登录页保持一致 */
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

<style scoped>
.wrapper {
  height: 100vh;
  background: url('../assets/imgs/login.png');
  background-size: cover;
  background-position: bottom;
  background-repeat: no-repeat;
  overflow: hidden;
  position: relative; /* 新增：为按钮定位做父级参考 */
}
</style>