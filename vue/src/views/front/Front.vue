<template>
  <div>
    <div style="display: flex; height: 60px; border-bottom: 1px solid #eee; position: relative;">
      <div style="width: 300px; display: flex; padding-left: 30px; align-items: center;">
        <div style="width: 60px;">
          <img src="../../assets/imgs/NavMenuImg.png" alt="" style="width: 50px;">
        </div>
        
        <div style="margin-left: -5px;">
          <img 
            src="../../assets/imgs/fontxiyue.png" 
            alt="曦岳论坛" 
            style="height: 50px;"
          >
        </div>
      </div>
      <div style="flex: 1; display: flex; align-items: center;">
        <el-menu :default-active="'1'" class="el-menu-demo" mode="horizontal" router style="width: 100%;">
          <el-menu-item index="/front/home" style="font-size: 21px">首页</el-menu-item>
          <el-menu-item index="/front/caipu" style="font-size: 21px">帖子</el-menu-item>
          <el-menu-item index="/front/forum"  style="font-size: 21px">论坛</el-menu-item>
          <el-menu-item index="/front/collection"  style="font-size: 21px">我的收藏</el-menu-item>
          <el-menu-item index="/front/advice"  style="font-size: 21px">意见栏</el-menu-item>
        </el-menu>
      </div>
      <div style="width: 200px; display: flex; align-items: center; justify-content: flex-end; padding-right: 30px; height: 100%;">
        <div v-if="!user.username">
          <el-button style="color:whitesmoke; border-color:#FBAEAB; background:#FBAEAB" @click="$router.push('/login')">登录</el-button>
          <el-button style="color:whitesmoke; border-color:#FB8B63; background:#FB8B63" @click="$router.push('/register')">注册</el-button>
        </div>
        <div v-else>
          <el-dropdown 
            trigger="hover" 
            style="cursor: pointer; display: flex; align-items: center;"
          >
            <div style="display: inline-flex; align-items: center; padding: 2px 6px; border-radius: 20px; transition: all 0.3s ease; height: 40px; margin: 0;" class="user-avatar-container">
              <img 
                :src="user.avatarUrl || defaultAvatar" 
                alt="用户头像"
                style="width: 32px; height: 32px; border-radius: 50%; margin-right: 5px; 
                       border: 2px solid transparent; 
                       background: linear-gradient(#fff, #fff) padding-box, 
                                   linear-gradient(to right, #FBAEAB, #FB8B63) border-box;
                       box-shadow: 0 2px 6px rgba(251, 139, 99, 0.12);"
              >
              <span style="color: #333; font-weight: 500; font-size: 14px; margin-right: 4px;">{{ user.nickname }}</span>
              <i class="el-icon-arrow-down" style="color:#FBAEAB; transition: transform 0.3s ease; font-size: 14px;"></i>
            </div>
            <el-dropdown-menu slot="dropdown" style="width: 110px; text-align: center; 
                                                  border-radius: 8px; border: none; 
                                                  box-shadow: 0 4px 12px rgba(251, 174, 171, 0.15);
                                                  padding: 6px 0; margin-top: 10px !important;">
              <el-dropdown-item style="font-size: 14px; padding: 6px 0; color:#FBAEAB; line-height: 1.4;">
                <router-link to="/front/password" style="text-decoration: none; color: inherit;">修改密码</router-link>
              </el-dropdown-item>
              <el-dropdown-item style="font-size: 14px; padding: 6px 0; color:#FBAEAB; line-height: 1.4;">
                <router-link to="/front/person" style="text-decoration: none; color: inherit;">个人信息</router-link>
              </el-dropdown-item>
              <!-- 新增：我的成就选项 -->
              <el-dropdown-item style="font-size: 14px; padding: 6px 0; color:#FBAEAB; line-height: 1.4; border-bottom: 1px solid #f5f5f5;">
                <router-link to="/front/achievement" style="text-decoration: none; color: inherit;">我的成就</router-link>
              </el-dropdown-item>
              <el-dropdown-item style="font-size: 14px; padding: 6px 0; color:#FB8B63; line-height: 1.4;">
                <span style="text-decoration: none" @click="logout">退出</span>
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>

    <div style="width: 1100px; margin: 0 auto; min-height: 600px;">
      <transition name="fade-up" mode="out-in">
        <router-view key="$route.fullPath"></router-view>
      </transition>
    </div>
  </div>
</template>

<script>
export default {
  name: "Front",
  data() {
    return {
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
      defaultAvatar: "https://picsum.photos/32/32"
    }
  },
  methods: {
    logout() {
      this.$store.commit("logout")
      this.$message.success("退出成功")
    }
  }
}
</script>

<style scoped>
.item{
  display: inline-block;
  width: 100px;
  text-align: center;
  cursor: pointer
}
.item a {
  color: #FBAEAB;
}
.item:hover{
  background-color: #FBAEAB;
}

.fade-up-enter-active {
  animation: fadeUp 0.45s ease forwards;
}
.fade-up-leave-active {
  animation: fadeUpOut 0.3s ease forwards;
}

@keyframes fadeUp {
  from {
    opacity: 0;
    transform: translateY(25px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
@keyframes fadeUpOut {
  from {
    opacity: 1;
    transform: translateY(0);
  }
  to {
    opacity: 0;
    transform: translateY(-10px);
  }
}

/* 导航统一淡红色 */
:deep(.el-menu--horizontal .el-menu-item.is-active) {
  color: #FBAEAB !important;
  border-bottom: 2px solid #FBAEAB !important;
}
:deep(.el-menu--horizontal .el-menu-item:hover) {
  color: #FBAEAB !important;
}
:deep(.el-button--primary) {
  background-color: #FBAEAB !important;
  border-color: #FBAEAB !important;
}
:deep(.el-button--primary:hover) {
  background-color: #FB8B63 !important;
  border-color: #FB8B63 !important;
}

.user-avatar-container:hover {
  background-color: #fef7f6;
}
.user-avatar-container:hover i {
  transform: rotate(180deg);
  color: #FB8B63 !important;
}

:deep(.el-dropdown-item:hover) {
  background-color: #FDF2F2 !important;
  color: #FBAEAB !important;
}
:deep(.el-dropdown-menu) {
  z-index: 9999 !important;
}

/* 兜底：强制导航栏内所有子元素垂直居中 */
:deep(.el-menu--horizontal) {
  line-height: 60px !important;
}
</style>