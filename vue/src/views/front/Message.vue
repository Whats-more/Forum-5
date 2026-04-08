<template>
    <div >
        <el-row style="margin-top: 20px">
            <el-col :span="24" >
                <el-card>
                    <div style="display: flex">
                        <div style="color: dodgerblue; font-size: 20px; flex: 1">分类</div>
                        <div style="flex: 1; text-align: right">共 <span style="font-size: 20px; color: orange">{{total}}</span> 条</div>
                    </div>
                    <!--                    分割线-->
                    <div style="height: 1px; margin: 10px 0; background-color: #ccc"></div>
                    <div style="display: flex; flex-direction: row">
                        <div class="category" @click="select(item.name)" v-for="item in categorys" :class="{ categoryActive: item.name === index }">{{ item.name }}</div>
                    </div>
                </el-card>



                <el-card style="min-height: 800px; margin-top: 20px; position: relative">


                    <div style="padding: 20px; border-bottom: 1px solid #ccc" v-for="item in blogs">
                        <el-row>
                            <el-col :span="18">
                                <div style="font-size: 20px"><b style="cursor: pointer" @click="jump(item)">{{ item.title }}</b></div>
                                <div style="padding: 20px 0; color: #888; margin-top: 20px">{{ item.description }}</div>
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
        name: "Message",
        data(){
            return{
                total: 0,



            }
        }
    }
</script>

<style scoped>

</style>