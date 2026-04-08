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
        <h2 style="background-color:#076FC6;margin: auto;text-align: center; font-size: 30px;color:white">热门帖子</h2>

      </el-header>
      <el-container>

        <el-main>
          <!--美食卡片展示-->

<!--最热门-->

          <el-row :gutter="10">
            <el-col :span="6" v-for=" articles in tableDataRead" :key="articles.index" style="margin-bottom: 10px">
              <el-card :body-style="{ padding: '2px'}" >
              <div style="background-color: white; padding: 10px; cursor: pointer" @click="$router.push('/front/articlesDetail?id=' + articles.id)">
                <img :src="articles.cover" alt="" style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px">

                <div style="padding: 14px;">

                  <span  class="title">{{articles.title}}</span>
                  <div style="font-size: 10px;margin-top: 10px">

                    by  {{articles.username}}
                  </div>
                </div>
              </div>
              </el-card>
            </el-col>
          </el-row>


        </el-main>
     </el-container>

<!--      最新帖子-->


      <el-header height="40px" >
        <h2 style="background-color:#076FC6;margin: auto;text-align: center; font-size: 30px;color:white">最新帖子</h2>

      </el-header>


      <el-container>

        <el-main>
          <!--美食卡片展示-->



          <el-row :gutter="10">
            <el-col :span="6" v-for=" articles in articles" :key="articles.id" style="margin-bottom: 10px">
              <el-card :body-style="{ padding: '2px'}" >
                <div style="background-color: white; padding: 10px; cursor: pointer" @click="$router.push('/front/articlesDetail?id=' + articles.id)">
                  <img :src="articles.cover" alt="" style="width: 100%; height: 200px; overflow: hidden; border-radius: 10px">

                  <div style="padding: 14px;">

                    <span class="title">{{articles.title}}</span>
                    <div style="font-size: 10px;margin-top: 10px">

                      by  {{articles.username}}
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
      lun: [],
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
    this.request.get("/lun").then( res =>{ //axios 获取后台lun传过来的数据
      this.lun =res.data })

      this.request.get("/articles/page", {  //分页搜索
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
        }
      }).then(res => {                    //获取后台传入的数据
        this.articles = res.data.records
        this.total = res.data.total
      })

    this.request.get("/articles/read",{  //分页查询按照阅读数
      params: {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
      }
    }).then(res => {
      console.log(res)
      this.tableDataRead = res.data.records
    })

    this.request.get("/articles/good",{  //分页查询按照点赞数降序
      params: {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
      }
    }).then(res => {
      this.tableDataGood = res.data.records
    })


    this.request.get("/articles/date",{  //分页查询按照发布时间降序
      params: {
        pageNum: this.pageNum,
        pageSize: this.pageSize,
      }
    }).then(res => {
      this.tableDataDate = res.data.records
    })


    },
    //
    // loadRead() {
    //   this.request.get("/articles/type/read").then(res => {   //阅读数
    //     this.tableDataRead = res.data
    //   })
    // },
    // loadGood() {
    //   this.request.get("articles/type/good").then(res => {  //点赞数排序
    //     this.tableDataGood = res.data
    //   })
    // },
    // loadDate() {
    //   this.request.get("articles/type/good").then(res => {  //发布时间，最新
    //     this.tableDataDate = res.data
    //   })
    // },


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

  .el-card__body img{
    width: 100%;
  }
.title:hover{
  color:  #436EEE !important;

}

</style>
