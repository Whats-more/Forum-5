<template>
    <div>
        <el-row style="margin-top: 20px">
            <el-col :span="24" >
                <el-card>
                    <div style="display: flex">
                        <div style="color: dodgerblue; font-size: 20px; flex: 1">分类</div>
                        <div style="flex: 1; text-align: right">共 <span style="font-size: 20px; color: orange">{{total}}</span> 条</div>
                    </div>
                    <!--分割线-->
                    <div style="height: 1px; margin: 10px 0; background-color: #ccc"></div>


<!--分类   下拉~-->
                    <el-row :gutter="2">

                        <el-col :span="3"   v-for="item in category" :class="{ categoryActive: item.name === index } " style="margin-bottom: 5px">
                        <div class="category"  >
                            <el-button @click="select(item.name)" size="15px">{{ item.name }}</el-button>

                        </div>


                        </el-col>

                    </el-row>



                </el-card>



                <el-card style="min-height: 800px; margin-top: 20px; position: relative">


                    <div style="padding: 20px; border-bottom: 1px solid #ccc" v-for="item in articles">
                        <el-row>
                            <el-col :span="18">
                                <div style="font-size: 20px"><b style="cursor: pointer"  @click="$router.push('/front/articlesDetail?id=' + item.id)">{{ item.title }}</b></div>
                                <div style="padding: 20px 0; color: #888; margin-top: 20px"></div>
                                <div style="color: #888; margin-top: 20px">
                                    <div>
                                        <span><i class="el-icon-user"></i> {{ item.username }}</span>
                                        <span style="margin-left: 20px"><i class="el-icon-date"></i> {{ item.time }}</span>
                                        <span style="margin-left: 20px"><i class="el-icon-reading"></i> {{ item.readCount }}</span>
                                    </div>
                                </div>
                            </el-col>
                            <el-col :span="6">
                                <div style="padding: 10px">
                                    <el-image :src="item.cover" style="width: 100px; height: 100px"></el-image>
                                </div>
                            </el-col>
                        </el-row>
                    </div>

                    <div style="height: 50px; line-height: 50px; text-align: center;  margin-top: 10px;">
                        <el-pagination
                                @size-change="handleSizeChange"
                                @current-change="handleCurrentChange"
                                :current-page="pageNum"
                                :page-size="pageSize"
                                small
                                layout="prev, pager, next"
                                :total="total">
                        </el-pagination>
                    </div>
                </el-card>
            </el-col>
        </el-row>



    </div>
</template>

<script>
    export default {
        name: "Caipu",
        data(){
            return{
                category: [],
                articles:[],
                index: '',
                pageNum: 1,
                pageSize: 10,
                total:0,


                username: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}, //获取登入人的username

            }
        },
        created() {
            this.load()
        },
        methods: {
            load() {
                this.request.get("/category").then(res => {
                    this.category = res.data;
                    if (!this.index) {
                        this.index = res.data[0].name;
                    }
                    this.request.get("/articles/page?pageNum=" + this.pageNum + "&pageSize=" + this.pageSize + "&category=" + this.index, {
                        params: {
                            pageNum: 1,
                            pageSize: 10,
                            title: this.title,
                        }
                    }).then(res => {
                        this.articles = res.data.records
                        this.total = res.data.total
                    })

                })
            },
jump() {

},
            select(category) {
                this.index = category;
                console.log(this.index);
                this.load();
            },

            handleSizeChange(pageSize) {
                console.log(pageSize)
                this.pageSize = pageSize
                this.load()
            },
            handleCurrentChange(pageNum) {
                console.log(pageNum)
                this.pageNum = pageNum
                this.load()
            },



        }
    }
</script>

<style scoped>

</style>