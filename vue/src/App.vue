<template>
  <div id="app">
    <transition name="fade-up" mode="out-in">
      <router-view key="$route.fullPath"></router-view>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
/* 重要：让根容器占满全屏 */
html, body, #app {
  height: 100% !important;
  width: 100% !important;
  margin: 0;
  padding: 0;
}

/* 全局页面切换动画 —— 超强版 */
.fade-up-enter-active {
  animation: fadeUp 0.5s ease forwards !important;
  z-index: 20 !important;
  position: relative !important;
}
.fade-up-leave-active {
  animation: fadeOut 0.4s ease forwards !important;
  z-index: 1 !important;
  position: relative !important;
}

@keyframes fadeUp {
  0% {
    opacity: 0;
    transform: translateY(30px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes fadeOut {
  0% {
    opacity: 1;
    transform: translateY(0);
  }
  100% {
    opacity: 0;
    transform: translateY(-10px);
  }
}

/* ====================== */
/* 🔥 全局自适应样式（所有页面自动电脑+手机适配） */
/* ====================== */
* {
  box-sizing: border-box !important;
}

/* 页面通用容器 */
.page-container {
  position: relative;
  width: 100%;
  min-height: calc(100vh - 60px);
  padding: 20px 0;
}

/* ---------------------- */
/* 📱 手机端样式（≤768px） */
/* ---------------------- */
@media (max-width: 768px) {
  /* 页面间距 */
  .page-container {
    padding: 10px 15px !important;
  }

  /* 所有卡片自动全屏 */
  .el-card {
    width: 100% !important;
    max-width: 100% !important;
    margin: 15px 0 !important;
    padding: 15px !important;
  }

  /* 输入框、表单全屏 */
  .el-input,
  .el-textarea,
  .el-form {
    width: 100% !important;
  }

  /* 表单标签宽度适配手机 */
  .el-form-item__label {
    width: 65px !important;
  }

  /* 按钮全屏 */
  .el-button {
    width: 100% !important;
  }

  /* 布局：多列自动变成单列 */
  .el-row {
    flex-direction: column !important;
  }
  .el-col {
    width: 100% !important;
    margin-bottom: 15px !important;
  }
}
</style>