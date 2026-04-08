<template>
  <div class="wrapper">
    <div style="width: 30%; margin: 100px auto; background-color: white; border-radius: 10px;  display: flex;">  

      <!--  display:flex ：flex布局          -->
      <!-- <div style="flex: 1">
        <img :src="imgUrl" alt=""style="width: 100%">
      </div> -->

<!--      登录表单-->
      <div style="flex: 1;padding: 30px">

      <div style="margin:20px auto 25px; text-align: center; font-size: 28px;"><b>登 录</b></div>

        <el-form :model="user" :rules="rules" ref="userForm">
        <el-form-item prop="username" style="margin-top: 25px">
          <el-input  placeholder="请输入账号" size="medium" prefix-icon="el-icon-user" v-model="user.username"></el-input>
        </el-form-item>
        <el-form-item prop="password" style="margin-top: 15px">
          <el-input placeholder="请输入密码" size="medium" prefix-icon="el-icon-lock" show-password
                    v-model="user.password"></el-input>
        </el-form-item>


        <el-form-item style="margin: 30px 0; text-align: right">
          <el-button type="warning" size="medium" autocomplete="off" @click="$router.push('/register')" >注册</el-button>
          <el-button type="primary" size="medium" autocomplete="off" @click="login">登录</el-button>
        </el-form-item>
      </el-form>
      </div>
    </div>



  </div>
</template>

<script>
import {setRoutes} from "@/router";
import imgUrl from "../assets/imgs/login.png";


export default {
  name: "Login",

  data() {
    return {
      user: {},
      //表单校验
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
          {min: 3, max: 10, message: '长度在 3 到 5 个字符', trigger: 'blur'}
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
          {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
        ],
      },
      imgUrl:imgUrl
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
  }
</script>

<style scoped>


.wrapper {  
  height: 100vh;  
  background:  url('../assets/imgs/login.png');  
  background-size: cover; /* 使背景图自适应容器大小 */  
  background-position: center; /* 将背景图居中 */  
  background-repeat: no-repeat; /* 防止背景图重复 */  
  overflow: hidden;  
}  
</style>
