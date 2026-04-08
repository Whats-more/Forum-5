/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : a_old

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 19/09/2024 20:28:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `activityName` varchar(255)   NULL DEFAULT NULL COMMENT '活动名称',
                             `activityTypeId` int NULL DEFAULT NULL COMMENT '活动类型',
                             `activityDate` date NULL DEFAULT NULL COMMENT '活动日期',
                             `startTime` time NULL DEFAULT NULL COMMENT '开始时间',
                             `endTime` time NULL DEFAULT NULL COMMENT '结束时间',
                             `activityAddress` varchar(255)   NULL DEFAULT NULL COMMENT '活动地点',
                             `dId` int NULL DEFAULT NULL COMMENT '负责人id',
                             `activityDetail` varchar(255)   NULL DEFAULT NULL COMMENT '活动内容',
                             `image` varchar(600)   NULL DEFAULT NULL COMMENT '图片',
                             `state` int NOT NULL DEFAULT 1 COMMENT '活动状态',
                             `activityPoint` int NULL DEFAULT NULL COMMENT '活动积分',
                             `limitNum` int NOT NULL DEFAULT 0 COMMENT '报名人数限制',
                             `signNum` int NOT NULL DEFAULT 0 COMMENT '已报名人数',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (16, '健康讲座	', 13, '2024-09-19', '18:59:54', '21:59:54', '老年活动中心	', 18, NULL, '/image/20240919/e27277960a3e4e76809999196031a2a4.jpg', 1, 10, 50, 1);
INSERT INTO `activity` VALUES (17, '瑜伽课程	', 14, '2024-09-20', '19:00:21', '22:00:21', '多功能厅	', 18, NULL, '/image/20240919/38ec3b238d9c410e8dfe045aa5bd1a8a.jpg', 1, 10, 50, 0);
INSERT INTO `activity` VALUES (18, '电影放映	', 16, '2024-09-20', '19:00:46', '21:00:46', '社区影院	', 18, NULL, '/image/20240919/5d0685f825f244a6b00869b019bbde01.jpg', 1, 10, 50, 0);
INSERT INTO `activity` VALUES (19, '书法培训	', 15, '2024-09-20', '19:01:19', '22:01:19', '文化科室', 18, NULL, '/image/20240919/dd2a75cb68e44542b0d414e8b06c6d54.jpg', 1, 10, 50, 0);
INSERT INTO `activity` VALUES (20, '社区联谊会	', 17, '2024-09-20', '19:04:55', '21:01:55', '社区广场', 18, NULL, '/image/20240919/fa4c3868e0a540a39afe53e6ac1faa23.jpg', 1, 10, 50, 0);

-- ----------------------------
-- Table structure for activity_state
-- ----------------------------
DROP TABLE IF EXISTS `activity_state`;
CREATE TABLE `activity_state`  (
                                   `id` int NOT NULL,
                                   `state` varchar(255)   NULL DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activity_state
-- ----------------------------
INSERT INTO `activity_state` VALUES (0, '已取消');
INSERT INTO `activity_state` VALUES (1, '未开始');
INSERT INTO `activity_state` VALUES (2, '报名截止');
INSERT INTO `activity_state` VALUES (3, '已结束');

-- ----------------------------
-- Table structure for activity_type
-- ----------------------------
DROP TABLE IF EXISTS `activity_type`;
CREATE TABLE `activity_type`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `type` varchar(255)   NULL DEFAULT NULL COMMENT '活动类型',
                                  `detail` varchar(255)   NULL DEFAULT NULL COMMENT '活动类型描述',
                                  `purpose` varchar(255)   NULL DEFAULT NULL COMMENT '活动目的',
                                  `state` int NOT NULL DEFAULT 0 COMMENT '活动状态：0：禁用，1：启用',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activity_type
-- ----------------------------
INSERT INTO `activity_type` VALUES (13, '健康讲座', '由专业人士讲解健康知识', '解健康知识	提高老年人的健康意识', 1);
INSERT INTO `activity_type` VALUES (14, '瑜伽课程', '提供瑜伽锻炼指导', '增强身体柔韧性与平衡能力', 1);
INSERT INTO `activity_type` VALUES (15, '书法培训', '书法艺术的学习与交流', '培养老年人的兴趣与艺术修养', 1);
INSERT INTO `activity_type` VALUES (16, '电影放映', '定期放映经典电影', '丰富老年人的文化生活', 1);
INSERT INTO `activity_type` VALUES (17, '社区联谊会', '促进邻里之间的交流与互动', '增强社区凝聚力与友谊', 1);

-- ----------------------------
-- Table structure for order_state
-- ----------------------------
DROP TABLE IF EXISTS `order_state`;
CREATE TABLE `order_state`  (
                                `id` int NOT NULL,
                                `state` varchar(255)   NULL DEFAULT NULL COMMENT '订单状态',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_state
-- ----------------------------
INSERT INTO `order_state` VALUES (1, '待受理');
INSERT INTO `order_state` VALUES (2, '待完成');
INSERT INTO `order_state` VALUES (3, '待评价');
INSERT INTO `order_state` VALUES (4, '已结束');

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report`  (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `uId` int NULL DEFAULT NULL COMMENT '用户编号',
                           `dId` int NULL DEFAULT NULL COMMENT '医护人员编号',
                           `time` datetime NULL DEFAULT NULL COMMENT '体检日期',
                           `height` double NULL DEFAULT NULL COMMENT '身高',
                           `weight` double NULL DEFAULT NULL COMMENT '体重',
                           `bp` varchar(255)   NULL DEFAULT NULL COMMENT '血压',
                           `WBC` varchar(255)   NULL DEFAULT NULL COMMENT '白细胞',
                           `RBC` varchar(255)   NULL DEFAULT NULL COMMENT '红细胞',
                           `PLT` varchar(255)   NULL DEFAULT NULL COMMENT '血小板',
                           `HGB` varchar(255)   NULL DEFAULT NULL COMMENT '血红蛋白',
                           `LYM` varchar(255)   NULL DEFAULT NULL COMMENT '淋巴细胞',
                           `NEUT` varchar(255)   NULL DEFAULT NULL COMMENT '中性粒细胞比率',
                           `TCHO` varchar(255)   NULL DEFAULT NULL COMMENT '总胆固醇',
                           `TG` varchar(255)   NULL DEFAULT NULL COMMENT '甘油三酯',
                           `HDLC` varchar(255)   NULL DEFAULT NULL COMMENT '高密度脂蛋白胆固醇',
                           `LDLC` varchar(255)   NULL DEFAULT NULL COMMENT '低密度脂蛋白胆固醇',
                           `ALT` varchar(255)   NULL DEFAULT NULL COMMENT '谷丙转氨酶',
                           `AST` varchar(255)   NULL DEFAULT NULL COMMENT '谷草转氨酶',
                           `SB` varchar(255)   NULL DEFAULT NULL COMMENT '血清胆红素',
                           `BS` varchar(255)   NULL DEFAULT NULL COMMENT '血糖',
                           `GLU` varchar(255)   NULL DEFAULT NULL COMMENT '尿葡萄糖',
                           `BIL` varchar(255)   NULL DEFAULT NULL COMMENT '尿胆红素',
                           `KET` varchar(255)   NULL DEFAULT NULL COMMENT '尿酮体',
                           `URO` varchar(255)   NULL DEFAULT NULL COMMENT '尿胆原',
                           `PH` varchar(255)   NULL DEFAULT NULL COMMENT '尿酸碱度',
                           `SG` varchar(255)   NULL DEFAULT NULL COMMENT '尿比重',
                           `UA` varchar(255)   NULL DEFAULT NULL COMMENT '血尿酸',
                           `Scr` varchar(255)   NULL DEFAULT NULL COMMENT '血肌酐',
                           `BUN` varchar(255)   NULL DEFAULT NULL COMMENT '尿素氮',
                           `AFP` varchar(255)   NULL DEFAULT NULL COMMENT '甲胎蛋白',
                           `CEA` varchar(255)   NULL DEFAULT NULL COMMENT '癌胚抗原',
                           `ferritin` varchar(255)   NULL DEFAULT NULL COMMENT '铁蛋白',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES (1, 8, 1, '2023-11-17 12:55:27', 177, 61, NULL, '5.9', '5.83', '170', '167', '40.4', '44.5', '3.52', '1.36', '1.62', '2.93', '32.1', '31', '17.4', NULL, '4.92', NULL, NULL, NULL, '6.5', '阴性', '301.6', '75.4', '2.84', NULL, NULL, NULL);
INSERT INTO `report` VALUES (2, 10, 1, '2024-05-20 12:57:25', 163, 52, NULL, '4.3', NULL, NULL, NULL, '50', '50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `report` VALUES (3, 8, 1, '2024-05-20 10:13:44', 171, 60, '110/90', '3.5', '5.0', '125', '145', '40.5', '50.5', '4.5', '1.28', '1.11', '0.05', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `report` VALUES (4, 9, 5, '2024-05-31 11:02:57', 172, 60, NULL, '5.0', NULL, NULL, NULL, '33', '55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `report` VALUES (5, 11, 5, '2024-06-01 09:33:14', 161, 50, NULL, '4.0', NULL, NULL, NULL, '44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `report` VALUES (6, 17, 1, '2024-09-19 18:42:48', 180, 73, '180', '4', '4.5', '125', '130', '30', '50', '3.1', '0.56', '0.78', '0', '0', '0', '0', NULL, '阴', '阴', '阴', '阳', '5', '1', '210', '62', '1.75', '7.0', '5.0', '15');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `role` varchar(255)   NULL DEFAULT NULL COMMENT '角色',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '社区管理员');
INSERT INTO `role` VALUES (2, '社区工作者');
INSERT INTO `role` VALUES (3, '社区医护人员');
INSERT INTO `role` VALUES (4, '普通用户');

-- ----------------------------
-- Table structure for role_function
-- ----------------------------
DROP TABLE IF EXISTS `role_function`;
CREATE TABLE `role_function`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `rId` int NOT NULL COMMENT '角色id',
                                  `fId` int NOT NULL COMMENT '功能id',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_function
-- ----------------------------
INSERT INTO `role_function` VALUES (1, 1, 1);
INSERT INTO `role_function` VALUES (2, 1, 2);
INSERT INTO `role_function` VALUES (3, 1, 3);
INSERT INTO `role_function` VALUES (4, 1, 4);
INSERT INTO `role_function` VALUES (5, 5, 5);
INSERT INTO `role_function` VALUES (6, 1, 6);
INSERT INTO `role_function` VALUES (7, 1, 7);
INSERT INTO `role_function` VALUES (8, 1, 8);
INSERT INTO `role_function` VALUES (9, 1, 9);
INSERT INTO `role_function` VALUES (10, 1, 10);
INSERT INTO `role_function` VALUES (11, 1, 11);
INSERT INTO `role_function` VALUES (12, 5, 12);
INSERT INTO `role_function` VALUES (13, 1, 13);
INSERT INTO `role_function` VALUES (14, 1, 14);
INSERT INTO `role_function` VALUES (15, 2, 1);
INSERT INTO `role_function` VALUES (16, 2, 2);
INSERT INTO `role_function` VALUES (17, 2, 3);
INSERT INTO `role_function` VALUES (18, 5, 5);
INSERT INTO `role_function` VALUES (19, 2, 7);
INSERT INTO `role_function` VALUES (20, 2, 8);
INSERT INTO `role_function` VALUES (21, 2, 9);
INSERT INTO `role_function` VALUES (22, 2, 10);
INSERT INTO `role_function` VALUES (24, 5, 12);
INSERT INTO `role_function` VALUES (25, 3, 4);
INSERT INTO `role_function` VALUES (26, 3, 11);
INSERT INTO `role_function` VALUES (27, 1, 15);
INSERT INTO `role_function` VALUES (28, 1, 16);
INSERT INTO `role_function` VALUES (29, 3, 16);

-- ----------------------------
-- Table structure for service_order
-- ----------------------------
DROP TABLE IF EXISTS `service_order`;
CREATE TABLE `service_order`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `uId` int NOT NULL COMMENT '用户编号',
                                  `mId` int NULL DEFAULT NULL COMMENT '社区工作者编号',
                                  `dId` int NULL DEFAULT NULL COMMENT '医护人员编号',
                                  `typeBId` int NULL DEFAULT NULL COMMENT '服务大类',
                                  `typeSId` int NULL DEFAULT NULL COMMENT '服务小类',
                                  `reserveDate` date NULL DEFAULT NULL COMMENT '预约日期',
                                  `serviceAddress` varchar(255)   NULL DEFAULT NULL COMMENT '服务地点',
                                  `orderDetail` varchar(255)   NULL DEFAULT NULL COMMENT '订单详情',
                                  `orderDate` date NULL DEFAULT NULL COMMENT '下单日期',
                                  `orderTime` time NULL DEFAULT NULL COMMENT '下单时间',
                                  `acceptDate` date NULL DEFAULT NULL COMMENT '受理日期',
                                  `acceptTime` time NULL DEFAULT NULL COMMENT '受理时间',
                                  `finishDate` date NULL DEFAULT NULL COMMENT '完成日期',
                                  `finishTime` time NULL DEFAULT NULL COMMENT '完成时间',
                                  `rate` double NULL DEFAULT NULL COMMENT '订单评分',
                                  `orderState` int NOT NULL DEFAULT 0 COMMENT '订单状态：0：待受理，1:已取消，2：待完成，3：待评价，4：已结束',
                                  `name` varchar(255)   NULL DEFAULT NULL COMMENT '服务人员姓名',
                                  `telephone` varchar(255)   NULL DEFAULT NULL COMMENT '服务人员电话',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of service_order
-- ----------------------------
INSERT INTO `service_order` VALUES (18, 17, 1, NULL, 24, 30, '2024-09-20', '小区门口', NULL, '2024-09-19', '18:40:21', '2024-09-19', '18:41:21', '2024-09-19', '19:13:43', 5, 4, 'yang', '17607605555');

-- ----------------------------
-- Table structure for service_type
-- ----------------------------
DROP TABLE IF EXISTS `service_type`;
CREATE TABLE `service_type`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `serviceName` varchar(255)   NULL DEFAULT NULL COMMENT '服务名称',
                                 `leaderId` int NULL DEFAULT NULL COMMENT '所属大类id',
                                 `image` varchar(500)   NULL DEFAULT NULL,
                                 `state` int NULL DEFAULT NULL COMMENT '状态：0：禁用，1：启用',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of service_type
-- ----------------------------
INSERT INTO `service_type` VALUES (24, '生活服务', NULL, NULL, 1);
INSERT INTO `service_type` VALUES (25, '健康服务', NULL, NULL, 1);
INSERT INTO `service_type` VALUES (26, '交通服务', NULL, NULL, 1);
INSERT INTO `service_type` VALUES (27, '心理咨询服务', NULL, NULL, 1);
INSERT INTO `service_type` VALUES (28, '社交活动服务', NULL, NULL, 1);
INSERT INTO `service_type` VALUES (29, '家政服务', 24, '/image/20240919/434101882b5b4687b597373f570221fe.jpg', 1);
INSERT INTO `service_type` VALUES (30, '购物代购', 24, '/image/20240919/6cc8dd80107f4a16babf8ec4d5c7aece.jpg', 1);
INSERT INTO `service_type` VALUES (31, '老年人健康检查活动', 25, '/image/20240919/6e66fafe81ae47ab8e635f3c4aa5dcee.jpg', 1);
INSERT INTO `service_type` VALUES (32, '心理健康讲座', 25, '/image/20240919/851c53b1d6e14dc18133415b040fed51.jpg', 1);
INSERT INTO `service_type` VALUES (35, '社区绘画兴趣小组', 27, '/image/20240919/1eb7fe62edcf444285352780ec18c9d4.jpg', 1);
INSERT INTO `service_type` VALUES (36, '社区美食聚餐', 28, '/image/20240919/048f15de0e2d45249454596a1d18828d.jpg', 1);

-- ----------------------------
-- Table structure for sys_function
-- ----------------------------
DROP TABLE IF EXISTS `sys_function`;
CREATE TABLE `sys_function`  (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `name` varchar(255)   NULL DEFAULT NULL COMMENT '功能名称',
                                 `path` varchar(255)   NULL DEFAULT NULL COMMENT '跳转路径',
                                 `fId` int NULL DEFAULT NULL COMMENT '父级id',
                                 `icon` varchar(255)   NULL DEFAULT NULL COMMENT '图标',
                                 `sort` int NULL DEFAULT NULL COMMENT '排序',
                                 `state` int NULL DEFAULT NULL COMMENT '功能状态：0：禁用，1：启用',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_function
-- ----------------------------
INSERT INTO `sys_function` VALUES (1, '社区养老服务管理系统', NULL, 0, '', 0, NULL);
INSERT INTO `sys_function` VALUES (2, '社区活动管理', NULL, 1, 'GoldMedal', 1, 1);
INSERT INTO `sys_function` VALUES (3, '社区服务管理', NULL, 1, 'Brush', 2, 1);
INSERT INTO `sys_function` VALUES (4, '健康管理', NULL, 1, 'Bicycle', 3, 1);
INSERT INTO `sys_function` VALUES (5, '助餐管理', NULL, 1, 'Bowl', 4, 1);
INSERT INTO `sys_function` VALUES (6, '系统管理', NULL, 1, 'Operation', 5, 1);
INSERT INTO `sys_function` VALUES (7, '活动管理', 'ActivityMenageView', 2, NULL, 11, 1);
INSERT INTO `sys_function` VALUES (8, '活动类型管理', 'ActivityTypeView', 2, NULL, 12, 1);
INSERT INTO `sys_function` VALUES (9, '服务分类', 'ServiceTypeView', 3, NULL, 31, 1);
INSERT INTO `sys_function` VALUES (10, '订单管理', 'ServiceOrderView', 3, NULL, 32, 1);
INSERT INTO `sys_function` VALUES (11, '健康档案', 'HealthMenageView', 4, NULL, 42, 1);
INSERT INTO `sys_function` VALUES (12, '菜谱管理', NULL, 5, NULL, 51, 1);
INSERT INTO `sys_function` VALUES (13, '用户管理', 'UserMenageView', 6, NULL, 61, 1);
INSERT INTO `sys_function` VALUES (14, '工作人员管理', 'WorkerMenageView', 6, NULL, 62, 1);
INSERT INTO `sys_function` VALUES (15, '医护人员管理', 'DoctorMenageView', 6, NULL, 63, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
                         `roleId` int NOT NULL COMMENT '用户角色：1：管理员，2：社区工作者，3：医护人员，4：普通用户',
                         `username` varchar(255)   NULL DEFAULT NULL COMMENT '用户名',
                         `password` varchar(255)   NULL DEFAULT NULL COMMENT '密码',
                         `name` varchar(255)   NULL DEFAULT NULL COMMENT '姓名',
                         `sex` varchar(10)   NULL DEFAULT NULL COMMENT '性别：1：男，2：女',
                         `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
                         `age` int NULL DEFAULT NULL COMMENT '年龄',
                         `idNum` varchar(255)   NULL DEFAULT NULL COMMENT '身份证号码',
                         `telephone` varchar(255)   NULL DEFAULT NULL COMMENT '联系电话',
                         `address` varchar(255)   NULL DEFAULT NULL COMMENT '住址',
                         `department` varchar(255)   NULL DEFAULT NULL COMMENT '科室',
                         `point` int NULL DEFAULT NULL COMMENT '个人积分',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1, 'admin', '123456', 'admin', NULL, NULL, NULL, '', '11111111111', NULL, NULL, NULL);
INSERT INTO `user` VALUES (2, 0, 'ouwen', '123456', '欧文', '男', '1993-03-03', 32, '', '12111111111', '', NULL, NULL);
INSERT INTO `user` VALUES (3, 0, 'pangke', '222222', '庞克', '男', '1990-02-02', 35, '', '12222222222', NULL, NULL, NULL);
INSERT INTO `user` VALUES (4, 0, 'cookie', '222222', '王饼干', '女', '1982-03-03', 69, '', '12333333333', '', NULL, NULL);
INSERT INTO `user` VALUES (5, 3, 'liuxing', '123456', '流星', '女', '1984-07-12', 40, NULL, '13111111111', NULL, NULL, NULL);
INSERT INTO `user` VALUES (6, 3, 'lisisi', '333333', '李思思', '女', '1989-06-30', 35, NULL, '13222222222', NULL, NULL, NULL);
INSERT INTO `user` VALUES (7, 3, 'xiangdong', '333333', '向东', '男', '1978-11-17', 46, NULL, '13333333333', NULL, NULL, NULL);
INSERT INTO `user` VALUES (8, 0, 'kangkai', '444444', '康凯', '男', '1951-10-10', 73, '110101195110101111', '14111111112', '丰汇园1栋1层102', NULL, 6);
INSERT INTO `user` VALUES (9, 0, 'zhaoxiao', '444444', '赵晓', '女', '1963-03-09', 61, '110101196303092222', '14222222222', '丰汇园2栋2层202', NULL, 8);
INSERT INTO `user` VALUES (10, 0, 'zhangshan', '444444', '章杉', '女', '1958-12-27', 66, '110101195812273333', '14333333333', '丰汇园3栋3层303', NULL, 6);
INSERT INTO `user` VALUES (11, 0, 'tina1', '444444', '缇娜', '女', '1965-11-12', 58, '110101196511124444', '14444444444', '丰汇园4栋4层404', NULL, 6);
INSERT INTO `user` VALUES (12, 0, 'timou', '444444', '提某', '男', '1960-05-20', 64, '110101196005205555', '14555555555', '丰汇园5栋5层505', NULL, 7);
INSERT INTO `user` VALUES (13, 0, 'timou1', 't33333', '提某', '男', NULL, NULL, NULL, '13444444445', NULL, NULL, NULL);
INSERT INTO `user` VALUES (14, 0, 'test1', 'test11', '测试1', '女', NULL, NULL, NULL, '16111111111', NULL, NULL, NULL);
INSERT INTO `user` VALUES (15, 0, 'yihutest1', 'yihutest1', '医护测试1', '男', NULL, NULL, NULL, '15222222222', NULL, NULL, NULL);
INSERT INTO `user` VALUES (16, 0, 'test2', 't222222', '测试2', '女', NULL, NULL, NULL, '13666666666', NULL, NULL, NULL);
INSERT INTO `user` VALUES (17, 4, 'linge', '123456', '黄黄黄', NULL, '2000-09-23', 23, '442000200009233333', '17607605111', NULL, NULL, NULL);
INSERT INTO `user` VALUES (18, 2, 'yange', '123456', 'yang', '男', NULL, NULL, NULL, '17607605222', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user_activity
-- ----------------------------
DROP TABLE IF EXISTS `user_activity`;
CREATE TABLE `user_activity`  (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `uId` int NULL DEFAULT NULL COMMENT '用户id',
                                  `aId` int NULL DEFAULT NULL COMMENT '活动id',
                                  `enterDate` date NULL DEFAULT NULL COMMENT '报名日期',
                                  `enterTime` time NULL DEFAULT NULL COMMENT '报名时间',
                                  `state` varchar(10)   NULL DEFAULT NULL COMMENT '0:已取消报名，1：报名审核中，2：报名成功',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4  ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_activity
-- ----------------------------
INSERT INTO `user_activity` VALUES (1, 8, 1, '2024-04-08', '15:41:25', '已取消报名');
INSERT INTO `user_activity` VALUES (2, 8, 2, '2024-04-22', '13:41:43', '报名成功');
INSERT INTO `user_activity` VALUES (3, 8, 3, '2024-02-25', '12:01:00', '报名成功');
INSERT INTO `user_activity` VALUES (4, 8, 5, '2024-05-12', '12:15:54', '报名成功');
INSERT INTO `user_activity` VALUES (5, 9, 1, '2024-05-12', '12:20:27', '报名成功');
INSERT INTO `user_activity` VALUES (6, 9, 2, '2024-05-12', '12:41:15', '报名成功');
INSERT INTO `user_activity` VALUES (7, 9, 5, '2024-05-12', '12:43:44', '报名成功');
INSERT INTO `user_activity` VALUES (8, 9, 6, '2024-05-12', '12:46:08', '报名成功');
INSERT INTO `user_activity` VALUES (9, 10, 1, '2024-05-12', '15:20:21', '报名成功');
INSERT INTO `user_activity` VALUES (10, 10, 3, '2024-05-12', '15:21:53', '已取消报名');
INSERT INTO `user_activity` VALUES (11, 10, 5, '2024-05-12', '15:22:17', '报名成功');
INSERT INTO `user_activity` VALUES (12, 11, 3, '2024-05-12', '15:23:00', '报名成功');
INSERT INTO `user_activity` VALUES (13, 12, 1, '2024-05-12', '15:30:34', '报名成功');
INSERT INTO `user_activity` VALUES (14, 11, 6, '2024-05-16', '17:46:43', '已取消报名');
INSERT INTO `user_activity` VALUES (15, 12, 4, '2024-04-10', '09:13:01', '报名成功');
INSERT INTO `user_activity` VALUES (16, 11, 4, '2024-04-19', '10:14:57', '报名成功');
INSERT INTO `user_activity` VALUES (17, 9, 7, '2024-05-27', '00:10:02', '报名成功');
INSERT INTO `user_activity` VALUES (18, 11, 7, '2024-05-29', '10:10:21', '报名成功');
INSERT INTO `user_activity` VALUES (19, 10, 7, '2024-05-30', '11:32:31', '报名成功');
INSERT INTO `user_activity` VALUES (20, 12, 7, '2024-05-30', '12:32:52', '报名成功');
INSERT INTO `user_activity` VALUES (21, 10, 6, '2024-06-01', '00:35:15', '报名成功');
INSERT INTO `user_activity` VALUES (22, 8, 6, '2024-05-31', '10:41:07', '报名成功');
INSERT INTO `user_activity` VALUES (23, 8, 8, '2024-06-01', '09:25:05', '报名成功');
INSERT INTO `user_activity` VALUES (24, 17, 11, '2024-09-19', '18:40:33', '报名成功');
INSERT INTO `user_activity` VALUES (25, 17, 16, '2024-09-19', '20:00:24', '报名成功');

SET FOREIGN_KEY_CHECKS = 1;
