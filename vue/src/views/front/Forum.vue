<template>
    <div>
        <!--回到顶部轮子    -->
        <vueToTop type="4" size="50" right="45" bottom="45" color="	#912CEE"></vueToTop>

<div style="display: flex">


<!--左-->
    <div style="background-color: white ;border-radius: 10px;width: 754px" class="container-height" >

<!--搜索-->
        <div style="margin: 10px 0">
            <el-input size="small" style="width: 300px" placeholder="请输入要搜索文章的标题" suffix-icon="el-icon-search" v-model="title"></el-input>
            <el-button class="ml-5" type="primary" @click="load" size="small">搜索</el-button>
            <el-button type="warning" @click="reset" size="small">重置</el-button>
        </div>


<!--左侧帖子部分-->

                <div  style="display: flex ;padding: 10px" v-for="item in articleData" :key="item.id">
            <el-card  style="width: 100%" >
        <div>
    <!-- 1.顶层头像和昵称-->
                <div style="display: flex">
                    
                    <div style="width: 80px">
                        <img style="width: 50px; height: 50px; border-radius: 50%" :src="item.userAvatar" alt="">
                    </div>
            
                    <div style="flex: 1; line-height: 25px" >
                       <div style="font-weight: bold">{{item.username}} </div>
                       <div style="font-size: 12px;color: #999">{{item.time}}</div>
                    </div>

                    <!--关注 -->
                    <!-- <div style="width: 60px">
                        <el-button >关注</el-button>
                    </div> -->


            </div>
    <!--2.贴子内容部分 -->
                <div style="margin: 10px 0;font-size: 14px;line-height: 25px;text-align: justify;" class="content " @click="$router.push('/front/articlesDetail?id=' + item.id)">

                    {{item.title}}
                    </div>

                <!-- 3.帖子的图片 -->
                <div style="margin: 10px 0;">

                    <el-row :gutter="10" >
                        <el-col :span="10" style="margin: 10px 0">

                            <img style="width: 65%" :src="item.cover" alt="">

                        </el-col>


                    </el-row>
                </div>



    <!--4.底部话题标签 浏览量 评论 点赞-->

                <div style="margin: 10px 0 ; display: flex;line-height: 25px">
                         <div style="width: 50%">
                         <el-tag type="primary" > #{{item.category}}</el-tag>
                         <el-tag type="primary" style="margin-left: 10px"> #话题</el-tag>
                         </div >


                        <div style="margin: 10px 0 0;width: 50% ;color: #999;font-size: 13px; text-align: right">
                            <i><img style="width: 20px" :src="icon[2]" alt="" ></i> {{ item.readCount }}

                            <i style="margin-left: 10px "><img style="width: 20px" :src="icon[0]" alt="" ></i>{{ item.goodCount }}

                            <i style="margin-left: 10px "><img style="width: 20px" :src="icon[1]" alt="" ></i>
                        </div>


                </div>



        </div>
            </el-card>

                </div>
        <div style="padding: 10px 0">
            <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="pageNum"
                    :page-sizes="[2, 5, 10, 20]"
                    :page-size="pageSize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="total">
            </el-pagination>
        </div>

    </div>
<!--右侧-->

    <div style="background-color: white ;border-radius: 10px;width: 300px;margin-top: 62px" class="container-height">

    <!--发帖按钮-->
        <el-card >

            <el-button type="primary" round style="width: 100%" @click="handleAdd">发表文章</el-button>

        </el-card>
    <!--点赞排行榜-->
    <el-card style="width: 100%;margin-top: 5px">
        <div style="padding: 10px; border: 1px solid #ccc; border-radius: 5px">
            <div style="padding: 10px 0;border-bottom: 1px solid cornflowerblue; font-size: 20px"><b >  最受欢迎帖子榜单</b></div>
            <div style="margin: 20px 0">
                <div style="padding: 10px; border-bottom: 1px dashed #ccc" v-for="item in tableDataGood" :key="item.id">
                    <span class="line" ></span>
                    <a style="margin-left: 5px" @click="$router.push('/front/articlesDetail?id=' + item.id)"><i class="el-icon-food" > {{item.title}} </i></a>
                </div>

            </div>
        </div>
    </el-card>


<!--浏览量排行榜-->
        <el-card style="width: 100%;margin-top: 5px">
            <div style="padding: 10px; border: 1px solid #ccc; border-radius: 5px">
                <div style="padding: 10px 0;border-bottom: 1px solid cornflowerblue; font-size: 20px"><b >  帖子浏览量榜单</b></div>
                <div style="margin: 20px 0">
                    <div style="padding: 10px; border-bottom: 1px dashed #ccc" v-for="item in tableDataRead" :key="item.id">
                        <span class="line" ></span>
                        <a style="margin-left: 5px" @click="$router.push('/front/articlesDetail?id=' + item.id)"><i class="el-icon-food" > {{item.title}} </i></a>
                    </div>

                </div>
            </div>
        </el-card>


    </div>





    <!--    新增和编辑的弹窗-->
    <el-dialog title="信息" :visible.sync="dialogFormVisible" width="60%" :close-on-click-modal="false">
        <el-form label-width="120px" size="small" style="width: 90%;" :model="form" :rules="rules" ref="ruleForm">
            <el-form-item prop="title" label="文章标题：">
                <el-input v-model="form.title" autocomplete="off"></el-input>
            </el-form-item>

            <el-form-item label="分类">
                <el-select clearable v-model="form.category" placeholder="请选择分类" style="width: 100%">
                    <el-option v-for="item in category" :key="item.name" :label="item.name" :value="item.name"></el-option>
                </el-select>
            </el-form-item>

            <el-form-item prop="cover" label="封面：">
                <el-upload action="http://localhost:9090/file/upload" ref="img" :on-success="handleImgUploadSuccess">
                    <el-button size="small" type="primary">点击上传</el-button>
                </el-upload>
            </el-form-item>


            <el-form-item prop="content" label="文章内容：">
                <mavon-editor ref="md" v-model="form.content" :ishljs="true" @imgAdd="imgAdd"/>
            </el-form-item>



        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </div>
    </el-dialog>





       </div>
    </div>

</template>


<script>
    import icon_good from "../../assets/imgs/icons8-thumbs-up-65.png";
    import icon_comment from "../../assets/imgs/icons8-comments-48.png";
    import icon_view from "../../assets/imgs/icons8-eye-48.png";
    import icon_top from "../../assets/imgs/icons8-collapse-arrow-50.png";
    import axios from "axios";



    export default {
        name: "Forum",
        data(){
           return{
               icon:[icon_good,icon_comment,icon_view,icon_top],
               form: {},
               articleData:[],
               category:[],
               title: '',
               content: '',
               multipleSelection: [],
               pageNum: 1,
               pageSize: 10,
               total: 0,
               tableDataGood:[],
               tableDataRead:[],
               dialogFormVisible: false,
               user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},//登录时获取用户数据
               viewDialogVis: false,
               rules: {        //前端表单验证规则
                   title: [
                       { required: true, message: '请输入文章标题', trigger: 'blur'}
                   ],
               },
               showBtn:false, // 回到顶部，默认是false，就是隐藏起来


           }


        },
        created() {
            this.load()
        },
        mounted() {
            window.addEventListener("scroll", this.showbtn, true);
        },
        methods: {
            view(content) {
                this.content = content
                this.viewDialogVis = true
            },
            // 绑定@imgAdd event
            imgAdd(pos, $file) {
                let $vm = this.$refs.md
                // 第一步.将图片上传到服务器.
                const formData = new FormData();
                formData.append('file', $file);
                axios({
                    url: 'http://localhost:9090/file/upload',
                    method: 'post',
                    data: formData,
                    headers: {'Content-Type': 'multipart/form-data'},
                }).then((res) => {
                    // 第二步.将返回的url替换到文本原位置![...](./0) -> ![...](url)
                    $vm.$img2Url(pos, res.data);
                })
            },
            load() {
                this.request.get("/articles/page", {
                    params: {
                        pageNum: this.pageNum,
                        pageSize: this.pageSize,
                        title: this.title,
                    }
                    }).then(res => {

                    this.articleData = res.data.records
                    console.log(this.articleData)
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


                this.request.get("/category").then(res => {   //分类
                    this.category = res.data
                })




            },
            changeEnable(row) {
                this.request.post("/articles/update", row).then(res => {
                    if (res.code === '200') {
                        this.$message.success("操作成功")
                    }
                })
            },
            handleAdd() {
                this.dialogFormVisible = true
                this.form = {}
                this.$nextTick(() => {
                    if(this.$refs.img) {
                        this.$refs.img.clearFiles();
                    }
                    if(this.$refs.file) {
                        this.$refs.file.clearFiles();
                    }
                })
            },
            handleEdit(row) {
                this.form = JSON.parse(JSON.stringify(row))
                this.dialogFormVisible = true
            },
            del(id) {
                this.request.delete("/articles/" + id).then(res => {
                    if (res.code === '200') {
                        this.$message.success("删除成功")
                        this.load()
                    } else {
                        this.$message.error("删除失败")
                    }
                })
            },
            handleSelectionChange(val) {
                console.log(val)
                this.multipleSelection = val
            },
            delBatch() {
                let ids = this.multipleSelection.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
                this.request.post("/articles/del/batch", ids).then(res => {
                    if (res.code === '200') {
                        this.$message.success("批量删除成功")
                        this.load()
                    } else {
                        this.$message.error("批量删除失败")
                    }
                })
            },
            save() {
                this.request.post("/articles", this.form).then(res => {
                    if (res.code === '200') {
                        this.$message.success("保存成功")
                        this.dialogFormVisible = false
                        this.load()
                    } else {
                        this.$message.error("保存失败")
                    }
                })
            },
            reset() {
                this.title = ""
                this.load()
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
            download(url) {
                window.open(url)
            },
            handleImgUploadSuccess(res) { //获取上传的图片
                this.form.cover = res
            },
            // 回到顶部


        }
    }
</script>

<style scoped>
    /* 只显示 3行文本，多余的用省略号*/
    .content{
        margin: 10px 0;
        line-height: 25px;
        text-align: justify;
        word-break: break-all;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 3;
        overflow: hidden;

    }


</style>



