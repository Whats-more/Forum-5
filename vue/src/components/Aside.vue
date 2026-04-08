<template>
  <el-menu :default-openeds="opens" style="min-height: 100%; overflow-x: hidden"
           background-color=" aliceblue"
           text-color=" black"
           active-text-color="#ffd04b"
           :collapse-transition="false"
           :collapse="isCollapse"
           router
  >

<!--    头-->


<!--      <b style="color: white; margin-left: 5px" v-show="logoTextShow">校园论坛后台管理</b>-->
<!--    </div>-->

    <div style="height: 60px;line-height: 60px;text-align: center">
      <img src="../assets/imgs/MenuImg.png" alt="" style="width: 50px;position: relative;top:7px;margin-right: 4px"  >
      <!-- v-show=" !isCollapse"  逻辑是一样的-->
      <b v-show="logoTextShow" style="color:  #171717;">校园论坛后台管理</b>
    </div>

    <div v-for="item in menus" :key="item.id">
      <div v-if="item.path">
        <el-menu-item :index="item.path">
          <i :class="item.icon"></i>
          <span slot="title">{{ item.name }}</span>
        </el-menu-item>
      </div>
      <div v-else>
        <el-submenu :index="item.id + ''">
          <template slot="title">
            <i :class="item.icon"></i>
            <span slot="title">{{ item.name }}</span>
          </template>
          <div  v-for="subItem in item.children" :key="subItem.id">
            <el-menu-item :index="subItem.path">
              <i :class="subItem.icon"></i>
              <span slot="title">{{ subItem.name }}</span>
            </el-menu-item>
          </div>
        </el-submenu>
      </div>
    </div>
  </el-menu>
</template>

<script>
export default {
  name: "Aside",
  props: {
    isCollapse: Boolean,
    logoTextShow: Boolean
  },
  data() {
    return {
      menus: localStorage.getItem("menus") ? JSON.parse(localStorage.getItem("menus")) : [],
      opens: localStorage.getItem("menus") ? JSON.parse(localStorage.getItem("menus")).map(v => v.id + '') : []
    }
  },
}
</script>

<style>

<!--  菜单点击的背景颜色-->
.el-menu-item.is-active {
  background-color: rgb(255, 141, 227) !important;
}

/*展开*/
.el-menu-item:hover {
  background-color: rgb(136, 231, 255) !important;
}

.el-submenu__title:hover {
  background-color: rgb(242, 255, 244) !important;
}
/*解决收缩菜单文字不消失问题*/
.el-menu--collapse span {
  visibility: hidden;
}
</style>
