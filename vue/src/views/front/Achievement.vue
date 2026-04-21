<template>
  <div class="achievement-container">
    <div class="achievement-header">
      <h2 class="achievement-title">我的成就</h2>
      <p class="achievement-desc">记录你的论坛成长足迹</p>

      <!-- 测试模式开关按钮 -->
      <div class="test-mode">
        <button 
          class="test-btn" 
          @click="toggleTestMode"
          :class="{ active: testMode }"
        >
          {{ testMode ? '关闭测试模式' : '开启测试模式（点击成就切换状态）' }}
        </button>
      </div>
    </div>

    <div class="achievement-grid">
      <!-- 1. 老资历 -->
      <div 
        class="achievement-card" 
        :class="{ unlocked: achievement1.unlocked, locked: !achievement1.unlocked }"
        @click="toggleAchievement(1)"
      >
        <div class="card-icon">
          <img
            :src="achievement1.unlocked ? require('./pioneer.png') : require('./pioneerbw.png')"
            class="achievement-img"
          >
        </div>
        <div class="card-title">{{ achievement1.name }}</div>
        <div class="card-desc">{{ achievement1.desc }}</div>
        <div class="card-time" v-if="achievement1.unlocked">
          达成时间：{{ achievement1.time }}
        </div>
      </div>

      <!-- 2. 神来之笔 -->
      <div 
        class="achievement-card" 
        :class="{ unlocked: achievement2.unlocked, locked: !achievement2.unlocked }"
        @click="toggleAchievement(2)"
      >
        <div class="card-icon">
          <img
            :src="achievement2.unlocked ? require('./writer.png') : require('./writerbw.png')"
            class="achievement-img"
          >
        </div>
        <div class="card-title">{{ achievement2.name }}</div>
        <div class="card-desc">{{ achievement2.desc }}</div>
        <div class="card-time" v-if="achievement2.unlocked">
          达成时间：{{ achievement2.time }}
        </div>
      </div>

      <!-- 3. 敬请期待 -->
      <div class="achievement-card locked">
        <div class="card-icon">
          <i class="el-icon-star-off"></i>
        </div>
        <div class="card-title">敬请期待</div>
        <div class="card-desc">更多成就正在开发中</div>
      </div>

      <!-- 4. 敬请期待 -->
      <div class="achievement-card locked">
        <div class="card-icon">
          <i class="el-icon-star-off"></i>
        </div>
        <div class="card-title">敬请期待</div>
        <div class="card-desc">更多成就正在开发中</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Achievement",
  data() {
    return {
      testMode: false, // 测试模式开关
      achievement1: {
        name: "老资历",
        desc: "注册论坛账号自动获得",
        unlocked: false,
        time: ""
      },
      achievement2: {
        name: "神来之笔",
        desc: "在论坛上发布第一篇文章",
        unlocked: false,
        time: ""
      }
    };
  },
  mounted() {
    this.checkAchievements();
  },
  methods: {
    // 正常检测成就
    checkAchievements() {
      if (this.testMode) return;

      const user = JSON.parse(localStorage.getItem("user") || "{}");
      const articles = JSON.parse(localStorage.getItem("articles") || "[]");

      if (user && Object.keys(user).length > 0) {
        this.achievement1.unlocked = true;
        this.achievement1.time = user.createTime || new Date().toLocaleDateString();
      } else {
        this.achievement1.unlocked = false;
      }

      if (articles && articles.length > 0) {
        this.achievement2.unlocked = true;
        this.achievement2.time = articles[0].createTime || "";
      } else {
        this.achievement2.unlocked = false;
      }
    },

    // 切换测试模式
    toggleTestMode() {
      this.testMode = !this.testMode;
      if (!this.testMode) {
        // 关闭测试，恢复正常成就状态
        this.checkAchievements();
      }
    },

    // 测试模式：点击成就卡片切换点亮/熄灭
    toggleAchievement(num) {
      if (!this.testMode) return;

      if (num === 1) {
        this.achievement1.unlocked = !this.achievement1.unlocked;
        if (this.achievement1.unlocked) {
          this.achievement1.time = "测试时间 " + new Date().toLocaleDateString();
        } else {
          this.achievement1.time = "";
        }
      } else if (num === 2) {
        this.achievement2.unlocked = !this.achievement2.unlocked;
        if (this.achievement2.unlocked) {
          this.achievement2.time = "测试时间 " + new Date().toLocaleDateString();
        } else {
          this.achievement2.time = "";
        }
      }
    }
  }
};
</script>

<style scoped>
.achievement-container {
  width: 1100px;
  margin: 30px auto;
  padding: 20px;
  background: #fff;
  border-radius: 12px;
}
.achievement-header {
  text-align: center;
  margin-bottom: 40px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}
.achievement-title {
  font-size: 38px;
  font-weight: 700;
  background: linear-gradient(to right, #00c6ff, #0072ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: inline-block;
}
.achievement-desc {
  color: #666;
  font-size: 15px;
}

/* 测试模式按钮样式 */
.test-mode {
  margin-top: 15px;
}
.test-btn {
  padding: 8px 16px;
  border: none;
  border-radius: 8px;
  background: #ccc;
  color: #333;
  cursor: pointer;
  font-size: 14px;
  transition: 0.3s;
}
.test-btn.active {
  background: #ff4444;
  color: #fff;
}

.achievement-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 22px;
}
.achievement-card {
  background: #fdfdfd;
  border-radius: 16px;
  padding: 20px 16px;
  text-align: center;
  border: 1px solid #e0e0e0;
  transition: all 0.3s ease;
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
}
.achievement-card.locked {
  filter: grayscale(100%);
  opacity: 0.5;
}
.achievement-card.unlocked {
  border-color: #ffd700 !important;
}
.achievement-card.unlocked:hover {
  box-shadow: 0 0 20px rgba(255, 215, 0, 0.4) !important;
}
.achievement-card:hover {
  transform: translateY(-4px);
}
.card-icon {
  width: 150px;
  height: 150px;
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 60px;
  color: #00c6ff;
}
.achievement-img {
  width: 150px;
  height: 150px;
  object-fit: contain;
}
.card-title,
.card-desc,
.card-time {
  width: 100%;
  text-align: center;
  margin: 0 auto;
}
.card-title {
  font-size: 18px;
  font-weight: 500;
  color: #333;
  margin-bottom: 6px;
}
.card-desc {
  font-size: 13px;
  color: #777;
  margin-bottom: 8px;
}
.card-time {
  font-size: 12px;
  color: #ffd700;
  font-weight: 500;
}
</style>