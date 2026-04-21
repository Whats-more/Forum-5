<template>
  <div class="feedback-container">
    <!-- 孟菲斯动画背景 -->
    <div class="memphis-bg">
      <div class="shape shape-1"></div>
      <div class="shape shape-2"></div>
      <div class="shape shape-3"></div>
      <div class="shape shape-4"></div>
      <div class="shape shape-5"></div>
      <div class="shape shape-6"></div>
      <div class="shape shape-7"></div>
      <div class="shape shape-8"></div>
    </div>

    <el-row style="margin-top: 20px; position: relative; z-index: 10" :gutter="20">
      <!-- 左侧：意见反馈 -->
      <el-col :span="14">
        <el-card class="glow-card floating-card">
          <div class="card-title">意见反馈</div>
          <div class="divider"></div>

          <el-form :model="feedback" label-width="80px" ref="feedbackRef">
            <el-form-item
              label="意见标题"
              prop="title"
              :rules="[{ required: true, message: '请输入意见标题', trigger: 'blur' }]"
            >
              <el-input v-model="feedback.title" placeholder="请简要描述你的意见" style="width: 500px" class="glow-input" />
            </el-form-item>

            <el-form-item
              label="意见内容"
              prop="content"
              :rules="[{ required: true, message: '请输入意见内容', trigger: 'blur' }]"
            >
              <el-input
                v-model="feedback.content"
                type="textarea"
                rows="13"
                placeholder="请详细描述你的意见"
                style="width: 500px"
                class="glow-input"
              />
            </el-form-item>

            <el-form-item>
              <el-button class="neon-pulse-btn" @click="submitFeedback">提交意见</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>

      <!-- 右侧：打赏我们 -->
      <el-col :span="10">
        <el-card class="glow-card floating-card delay-1">
          <div class="card-title">打赏我们</div>
          <div class="divider"></div>

          <div class="donate-content">
            <p>感谢你一路以来对曦岳论坛的支持与陪伴！</p>
            <p>我们始终坚持为大家提供干净、优质、免费的交流平台。</p>
            <p>你的小小支持，是我们持续更新、维护服务器的最大动力！</p>
            <p>每一份鼓励，我们都将用心对待，努力让论坛变得更好～</p>
            <p class="donate-highlight">
              感谢你的爱心支持 ❤️
            </p>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "Advice",
  data() {
    return {
      feedback: { title: "", content: "", username: "" },
      username: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    };
  },
  created() {
    this.feedback.username = this.username.username || "";
  },
  methods: {
    submitFeedback() {
      this.$refs.feedbackRef.validate(valid => {
        if (valid) {
          this.request.post("/feedback/add", this.feedback).then(res => {
            this.$message.success("意见提交成功！");
            this.feedback.title = "";
            this.feedback.content = "";
          }).catch(err => {
            this.$message.error("提交失败");
          });
        }
      });
    }
  }
};
</script>

<style scoped>
/* 外层容器 */
.feedback-container {
  position: relative;
  min-height: 100vh;
  padding: 20px 0;
  background: #fdfaff;
  overflow: hidden;
}

/* ========================== */
/* 孟菲斯风格动态背景 */
/* ========================== */
.memphis-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
  pointer-events: none;
}

.shape {
  position: absolute;
  opacity: 0.15;
  animation: float 12s infinite ease-in-out alternate;
}

.shape-1 {
  width: 70px; height: 70px; border-radius: 50%; background: #7fc2a6;
  top: 10%; left: 5%; animation-duration: 9s;
}
.shape-2 {
  width: 100px; height: 100px; background: #f8bbd0;
  top: 60%; left: 90%; animation-duration: 11s;
}
.shape-3 {
  width: 0; height: 0;
  border-left: 30px solid transparent;
  border-right: 30px solid transparent;
  border-bottom: 50px solid #ffd166;
  top: 30%; left: 85%; animation-duration: 7s;
}
.shape-4 {
  width: 80px; height: 25px; background: #95e1d3; border-radius: 50px;
  top: 80%; left: 15%; animation-duration: 13s;
}
.shape-5 {
  width: 50px; height: 50px; background: #cea5fb; transform: rotate(45deg);
  top: 5%; left: 70%; animation-duration: 8s;
}
.shape-6 {
  width: 120px; height: 30px; background: #ff9aaa; border-radius: 10px;
  top: 45%; left: 25%; animation-duration: 14s;
}
.shape-7 {
  width: 40px; height: 40px; border-radius: 50%; background: #64e9ee;
  top: 75%; left: 60%; animation-duration: 10s;
}
.shape-8 {
  width: 60px; height: 60px; background: #b4f8c8; border-radius: 30% 70% 70% 30%;
  top: 20%; left: 45%; animation-duration: 12s;
}

@keyframes float {
  0% { transform: translate(0, 0) rotate(0deg); }
  100% { transform: translate(30px, -30px) rotate(15deg); }
}

/* ========================== */
/* 卡片样式：发光 + 悬浮 */
/* ========================== */
.glow-card {
  border-radius: 18px !important;
  border: none !important;
  background: #ffffff !important;
  transition: all 0.4s ease;
  position: relative;
}

.floating-card {
  animation: float-up 4s infinite ease-in-out;
}

.delay-1 {
  animation-delay: 0.6s;
}

@keyframes float-up {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-8px); }
}

/* 标题 */
.card-title {
  color: #7fc2a6;
  font-size: 22px;
  font-weight: bold;
}

/* 分割线 */
.divider {
  height: 2px;
  margin: 12px 0 24px 0;
  background: #f8bbd0;
  border-radius: 1px;
}

/* 输入框 */
:deep(.glow-input .el-input__inner) {
  border-radius: 10px !important;
  border: 1px solid #e0d6ff !important;
  transition: all 0.3s;
}

/* 按钮 */
.neon-pulse-btn {
  background: #f8bbd0 !important;
  border-color: #f8bbd0 !important;
  color: #fff !important;
  border-radius: 10px !important;
  padding: 10px 25px !important;
  font-weight: bold;
}

/* 打赏文字 */
.donate-content {
  font-size: 15px;
  line-height: 1.9;
  color: #555;
}

.donate-highlight {
  margin-top: 15px;
  font-weight: bold;
  color: #f8bbd0;
  font-size: 16px;
}
</style>