<template>
  <div>

    <!--轮播图部分-->
    <el-carousel :interval="4000" type="card"  height="360px"  style="margin-top: 10px">
      <el-carousel-item v-for='(lun,index) in lun' :key='index'>
        <a :href="lun.link">
        <el-image
                style="height: auto"
                :src="lun.img"
                fit="fill"></el-image>
        </a>
      </el-carousel-item>
    </el-carousel>


    <!--内容部分-->
    <el-container>
      <el-header height="40px" >
        <h2 class="title-box hot">热门帖子</h2>
      </el-header>
      <el-container>

        <el-main>
          <el-row :gutter="10">
            <el-col :span="6" v-for=" articles in tableDataRead" :key="articles.id" style="margin-bottom: 10px">
              <el-card :body-style="{ padding: '2px'}" class="card-hot">
              <div style="background-color: white; padding: 10px; cursor: pointer" @click="$router.push('/front/articlesDetail?id=' + articles.id)">
                <img :src="articles.cover" alt="" style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px">

                <div style="padding: 14px;">
                  <span class="title">{{articles.title}}</span>
                  <div style="font-size: 10px; margin-top: 10px; color: #778CCD">
                    by {{articles.username}}
                  </div>
                </div>
              </div>
              </el-card>
            </el-col>
          </el-row>
        </el-main>
     </el-container>

      <el-header height="40px" >
        <h2 class="title-box new">最新帖子</h2>
      </el-header>

      <el-container>
        <el-main>
          <el-row :gutter="10">
            <el-col :span="6" v-for=" articles in articles" :key="articles.id" style="margin-bottom: 10px">
              <el-card :body-style="{ padding: '2px'}" class="card-new">
                <div style="background-color: white; padding: 10px; cursor: pointer" @click="$router.push('/front/articlesDetail?id=' + articles.id)">
                  <img :src="articles.cover" alt="" style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px">
                  <div style="padding: 14px;">
                    <span class="title">{{articles.title}}</span>
                    <div style="font-size: 10px; margin-top: 10px; color: #FB8B63">
                      by {{articles.username}}
                    </div>
                  </div>
                </div>
              </el-card>
            </el-col>
          </el-row>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "FrontHome",
  data() {
    return {
      lun: [
        { img: require("@/assets/imgs/示意图.jpg") },
        { img: require("@/assets/imgs/二.jpg") },
        { img: require("@/assets/imgs/1234.jpg") },
        { img: require("@/assets/imgs/未命名.jpg") }
      ],
      files: [],
      articles:[],
      pageNum: 1,
      pageSize:8,
      total: 0,
      tableDataRead:[],
      tableDataGood:[],
      tableDataDate:[],
    }
  },

  created() {
    this.load()
  },

  methods: {
    load() {
      this.request.get("/lun").then(res => {
        this.lun = res.data
      })

      this.request.get("/articles/page", {
        params: { pageNum: this.pageNum, pageSize: this.pageSize }
      }).then(res => {
        this.articles = res.data.records
        this.total = res.data.total
      })

      this.request.get("/articles/read", {
        params: { pageNum: this.pageNum, pageSize: this.pageSize }
      }).then(res => {
        this.tableDataRead = res.data.records
      })

      this.request.get("/articles/good", {
        params: { pageNum: this.pageNum, pageSize: this.pageSize }
      }).then(res => {
        this.tableDataGood = res.data.records
      })

      this.request.get("/articles/date", {
        params: { pageNum: this.pageNum, pageSize: this.pageSize }
      }).then(res => {
        this.tableDataDate = res.data.records
      })
    },

    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {
      this.pageNum = pageNum
      this.load()
    },
  }
}
</script>

<style scoped>
/* 热门标题：紫蓝色系 */
.title-box.hot {
  width: fit-content;
  margin: 0 auto;
  font-size: 22px;
  font-weight: 500;
  color: #778CCD;
  position: relative;
  padding-bottom: 8px;
}
.title-box.hot::after {
  content: "";
  position: absolute;
  left: 50%;
  bottom: 0;
  transform: translateX(-50%);
  width: 40px;
  height: 3px;
  background: #778CCD;
  border-radius: 2px;
}

/* 最新标题：暖黄 + 淡红 */
.title-box.new {
  width: fit-content;
  margin: 0 auto;
  font-size: 22px;
  font-weight: 500;
  color: #FBAEAB;
  position: relative;
  padding-bottom: 8px;
}
.title-box.new::after {
  content: "";
  position: absolute;
  left: 50%;
  bottom: 0;
  transform: translateX(-50%);
  width: 40px;
  height: 3px;
  background: #FBAEAB;
  border-radius: 2px;
}

/* 热门卡片 */
.card-hot {
  border: 1px solid #B5E2E7 !important;
  border-radius: 12px !important;
  box-shadow: 0 2px 8px rgba(119, 140, 205, 0.06) !important;
  transition: all 0.3s ease !important;
}
.card-hot:hover {
  transform: translateY(-4px);
  border-color: #778CCD !important;
  box-shadow: 0 6px 15px rgba(119, 140, 205, 0.12) !important;
}

/* 最新卡片 */
.card-new {
  border: 1px solid #DFF6E7 !important;
  border-radius: 12px !important;
  box-shadow: 0 2px 8px rgba(251, 174, 171, 0.06) !important;
  transition: all 0.3s ease !important;
}
.card-new:hover {
  transform: translateY(-4px);
  border-color: #FBAEAB !important;
  box-shadow: 0 6px 15px rgba(251, 139, 99, 0.12) !important;
}

.el-card__body img {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 8px;
  transition: transform 0.3s ease;
}
.el-card:hover img {
  transform: scale(1.05);
}

.title {
  font-size: 15px;
  color: #333;
}
.title:hover {
  color: #FB8B63 !important;
}
</style>