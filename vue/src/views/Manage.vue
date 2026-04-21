<template>
  <!--  后台管理页面-->
  <el-container style="min-height: 100vh">
    <el-aside :width="sideWidth + 'px'" style="box-shadow: 2px 0 6px rgb(0 21 41 /25%);">
      <Aside :isCollapse="isCollapse" :logoTextShow="logoTextShow" style="padding-bottom: 20px" />
    </el-aside>

    <el-container>
      <el-header style="border-bottom: 1px solid #ccc;">
        <Header :collapseBtnClass="collapseBtnClass" @asideCollapse="collapse" :user="user" />
      </el-header>

      <el-main>
        <!--        表示当前页面的子路由会在 <router-view /> 里面展示-->
        <router-view @refreshUser="getUser" />
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Aside from "@/components/Aside";
import Header from "@/components/Header";

export default {
  name: 'Home',
  data() {
    return {
      collapseBtnClass: 'el-icon-s-fold',
      isCollapse: false,
      sideWidth: 200,
      logoTextShow: true,
      user: {}
    }
  },
  components: {
    Aside,
    Header
  },
  created() {
    // 从后台获取最新的User数据
    this.getUser();
    // 初始化时检测屏幕尺寸，自动适配
    this.handleResize();
    // 监听窗口大小变化
    window.addEventListener('resize', this.handleResize);
  },
  destroyed() {
    // 销毁组件时移除监听，防止内存泄漏
    window.removeEventListener('resize', this.handleResize);
  },
  methods: {
    // 响应式处理：根据屏幕宽度自动调整侧边栏状态
    handleResize() {
      const screenWidth = window.innerWidth;
      // 手机屏幕（≤768px）默认收缩侧边栏
      if (screenWidth <= 768) {
        this.isCollapse = true;
        this.sideWidth = 64;
        this.collapseBtnClass = 'el-icon-s-unfold';
        this.logoTextShow = false;
      } else {
        // 大屏默认展开
        this.isCollapse = false;
        this.sideWidth = 200;
        this.collapseBtnClass = 'el-icon-s-fold';
        this.logoTextShow = true;
      }
    },
    // 点击收缩按钮触发
    collapse() {
      this.isCollapse = !this.isCollapse;
      if (this.isCollapse) {  // 收缩
        this.sideWidth = 64;
        this.collapseBtnClass = 'el-icon-s-unfold';
        this.logoTextShow = false;
      } else {   // 展开
        this.sideWidth = 200;
        this.collapseBtnClass = 'el-icon-s-fold';
        this.logoTextShow = true;
      }
    },
    getUser() {
      let username = localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")).username : "";
      if (username) {
        // 从后台获取User数据
        this.request.get("/user/username/" + username).then(res => {
          // 重新赋值后台的最新User数据
          this.user = res.data;
        });
      }
    }
  }
}
</script>

<style scoped>
/* 基础样式：保证容器全屏且无横向滚动 */
.el-container {
  width: 100%;
  overflow-x: hidden;
}

/* 手机端适配（屏幕宽度 ≤ 768px） */
@media (max-width: 768px) {
  .el-aside {
    width: 64px !important;
  }
  /* 头部适配：简化内边距和高度 */
  .el-header {
    padding: 0 10px !important;
    height: 50px !important;
    line-height: 50px !important;
  }
  /* 主内容区：适配手机窄屏 */
  .el-main {
    padding: 10px !important;
    width: 100%;
    overflow-x: hidden;
  }
}

/* 平板适配（768px ~ 992px） */
@media (min-width: 769px) and (max-width: 992px) {
  .el-aside {
    width: 180px !important;
  }
  .el-main {
    padding: 15px !important;
  }
}
</style>