/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50156
Source Host           : localhost:13306
Source Database       : base_rbac

Target Server Type    : MYSQL
Target Server Version : 50156
File Encoding         : 65001

Date: 2020-10-23 15:23:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(256) DEFAULT NULL COMMENT '图片地址',
  `alt` varchar(64) DEFAULT NULL COMMENT '描述',
  `state` int(11) DEFAULT '0' COMMENT '显示状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='轮播图';

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES ('7', 'http://localhost:8888/images/avcSTi-EGdsdpXGaJjkGhlYGuRmqVN97yyQShwNX8ovbMF6JuBDWN8BUF4VB5oV5joJrvItByyS4HHaWdXyO_DrXIaWutJls2xCVbatkhjUNNiIYVnHvzugZCuBITtvjski7YaLlHpkrQUr5euoQrg.jpg', '花千骨宠物乐园', '0', '2020-03-12 17:11:50');
INSERT INTO `banner` VALUES ('8', 'http://localhost:8888/images/cv5sdrdOLH_Q_8_zLoN7YjVT3H8FixmvTFf7zWvERZAb3fULDvxJT1BFUqCYISgVjoJrvItByyS4HHaWdXyO_DrXIaWutJls2xCVbatkhjUNNiIYVnHvzugZCuBITtvjski7YaLlHpkrQUr5euoQrg.jpg', '北京名佳动物医院', '0', '2020-03-12 17:12:51');
INSERT INTO `banner` VALUES ('9', 'http://localhost:8888/images/f756e57990aa3a53ee637dff83ed5b4e.jpg', '阿拉斯加', '0', '2020-03-12 17:13:37');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '字典名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据字典';

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES ('7', 'article_type', '文章类型', null);
INSERT INTO `dict` VALUES ('8', '其他', '其他', null);
INSERT INTO `dict` VALUES ('10', 'display_staus', '显示状态', null);

-- ----------------------------
-- Table structure for dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `dict_detail`;
CREATE TABLE `dict_detail` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL COMMENT '字典标签',
  `value` varchar(255) NOT NULL COMMENT '字典值',
  `sort` varchar(255) DEFAULT NULL COMMENT '排序',
  `dict_id` bigint(11) DEFAULT NULL COMMENT '字典id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK5tpkputc6d9nboxojdbgnpmyb` (`dict_id`) USING BTREE,
  CONSTRAINT `FK5tpkputc6d9nboxojdbgnpmyb` FOREIGN KEY (`dict_id`) REFERENCES `dict` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据字典详情';

-- ----------------------------
-- Records of dict_detail
-- ----------------------------
INSERT INTO `dict_detail` VALUES ('14', '常见问题', 'problem', '999', '7', null);
INSERT INTO `dict_detail` VALUES ('15', '新闻', 'news', '999', '7', null);
INSERT INTO `dict_detail` VALUES ('16', '狗狗训练', 'train', '999', '7', null);
INSERT INTO `dict_detail` VALUES ('17', '养护知识', 'conserve', '999', '7', null);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` bigint(20) DEFAULT NULL COMMENT '上级菜单ID',
  `type` int(11) DEFAULT NULL COMMENT '菜单类型',
  `title` varchar(255) DEFAULT NULL COMMENT '菜单标题',
  `name` varchar(255) DEFAULT NULL COMMENT '组件名称',
  `component` varchar(255) DEFAULT NULL COMMENT '组件',
  `menu_sort` int(5) DEFAULT NULL COMMENT '排序',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `path` varchar(255) DEFAULT NULL COMMENT '链接地址',
  `i_frame` bit(1) DEFAULT NULL COMMENT '是否外链',
  `cache` bit(1) DEFAULT b'0' COMMENT '缓存',
  `hidden` bit(1) DEFAULT b'0' COMMENT '隐藏',
  `permission` varchar(255) DEFAULT NULL COMMENT '权限',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_title` (`title`),
  UNIQUE KEY `uniq_name` (`name`),
  KEY `inx_pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', null, '0', '系统管理', null, null, '1', 'system', 'system', '\0', '\0', '\0', null, null, null, '2018-12-18 15:11:29', null);
INSERT INTO `sys_menu` VALUES ('2', '1', '1', '用户管理', 'User', 'system/user/index', '2', 'peoples', 'user', '\0', '\0', '\0', 'user:list', null, null, '2018-12-18 15:14:44', null);
INSERT INTO `sys_menu` VALUES ('3', '1', '1', '角色管理', 'Role', 'system/role/index', '3', 'role', 'role', '\0', '\0', '\0', 'roles:list', null, null, '2018-12-18 15:16:07', null);
INSERT INTO `sys_menu` VALUES ('5', '1', '1', '菜单管理', 'Menu', 'system/menu/index', '5', 'menu', 'menu', '\0', '\0', '\0', 'menu:list', null, null, '2018-12-18 15:17:28', null);
INSERT INTO `sys_menu` VALUES ('6', null, '0', '系统监控', null, null, '10', 'monitor', 'monitor', '\0', '\0', '\0', null, null, null, '2018-12-18 15:17:48', null);
INSERT INTO `sys_menu` VALUES ('7', '6', '1', '操作日志', 'Log', 'monitor/log/index', '11', 'log', 'logs', '\0', '\0', '\0', null, null, null, '2018-12-18 15:18:26', null);
INSERT INTO `sys_menu` VALUES ('9', '6', '1', 'SQL监控', 'Sql', 'monitor/sql/index', '18', 'sqlMonitor', 'druid', '\0', '\0', '\0', null, null, null, '2018-12-18 15:19:34', null);
INSERT INTO `sys_menu` VALUES ('10', null, '0', '组件管理', null, null, '50', 'zujian', 'components', '\0', '\0', '\0', null, null, null, '2018-12-19 13:38:16', null);
INSERT INTO `sys_menu` VALUES ('11', '10', '1', '图标库', 'Icons', 'components/icons/index', '51', 'icon', 'icon', '\0', '\0', '\0', null, null, null, '2018-12-19 13:38:49', null);
INSERT INTO `sys_menu` VALUES ('14', '36', '1', '邮件工具', 'Email', 'tools/email/index', '35', 'email', 'email', '\0', '\0', '\0', null, null, null, '2018-12-27 10:13:09', null);
INSERT INTO `sys_menu` VALUES ('15', '10', '1', '富文本', 'Editor', 'components/Editor', '52', 'fwb', 'tinymce', '\0', '\0', '\0', null, null, null, '2018-12-27 11:58:25', null);
INSERT INTO `sys_menu` VALUES ('16', '36', '1', '图床管理', 'Pictures', 'tools/picture/index', '33', 'image', 'pictures', '\0', '\0', '\0', 'pictures:list', null, null, '2018-12-28 09:36:53', null);
INSERT INTO `sys_menu` VALUES ('18', '36', '1', '存储管理', 'Storage', 'tools/storage/index', '34', 'qiniu', 'storage', '\0', '\0', '\0', 'storage:list', null, null, '2018-12-31 11:12:15', null);
INSERT INTO `sys_menu` VALUES ('19', '36', '1', '支付宝工具', 'AliPay', 'tools/aliPay/index', '37', 'alipay', 'aliPay', '\0', '\0', '\0', null, null, null, '2018-12-31 14:52:38', null);
INSERT INTO `sys_menu` VALUES ('21', null, '0', '多级菜单', null, '', '900', 'menu', 'nested', '\0', '\0', '', null, null, null, '2019-01-04 16:22:03', null);
INSERT INTO `sys_menu` VALUES ('22', '21', '1', '二级菜单1', null, 'nested/menu1/index', '999', 'menu', 'menu1', '\0', '\0', '\0', null, null, null, '2019-01-04 16:23:29', null);
INSERT INTO `sys_menu` VALUES ('23', '21', '1', '二级菜单2', null, 'nested/menu2/index', '999', 'menu', 'menu2', '\0', '\0', '\0', null, null, null, '2019-01-04 16:23:57', null);
INSERT INTO `sys_menu` VALUES ('24', '22', '1', '三级菜单1', null, 'nested/menu1/menu1-1', '999', 'menu', 'menu1-1', '\0', '\0', '\0', null, null, null, '2019-01-04 16:24:48', null);
INSERT INTO `sys_menu` VALUES ('27', '22', '1', '三级菜单2', null, 'nested/menu1/menu1-2', '999', 'menu', 'menu1-2', '\0', '\0', '\0', null, null, null, '2019-01-07 17:27:32', null);
INSERT INTO `sys_menu` VALUES ('28', '1', '1', '任务调度', 'Timing', 'system/timing/index', '999', 'timing', 'timing', '\0', '\0', '\0', 'timing:list', null, null, '2019-01-07 20:34:40', null);
INSERT INTO `sys_menu` VALUES ('30', '36', '1', '代码生成', 'GeneratorIndex', 'generator/index', '32', 'dev', 'generator', '\0', '', '\0', null, null, null, '2019-01-11 15:45:55', null);
INSERT INTO `sys_menu` VALUES ('32', '6', '1', '异常日志', 'ErrorLog', 'monitor/log/errorLog', '12', 'error', 'errorLog', '\0', '\0', '\0', null, null, null, '2019-01-13 13:49:03', null);
INSERT INTO `sys_menu` VALUES ('33', '10', '1', 'Markdown', 'Markdown', 'components/MarkDown', '53', 'markdown', 'markdown', '\0', '\0', '\0', null, null, null, '2019-03-08 13:46:44', null);
INSERT INTO `sys_menu` VALUES ('34', '10', '1', 'Yaml编辑器', 'YamlEdit', 'components/YamlEdit', '54', 'dev', 'yaml', '\0', '\0', '\0', null, null, null, '2019-03-08 15:49:40', null);
INSERT INTO `sys_menu` VALUES ('35', '1', '1', '部门管理', 'Dept', 'system/dept/index', '6', 'dept', 'dept', '\0', '\0', '\0', 'dept:list', null, null, '2019-03-25 09:46:00', null);
INSERT INTO `sys_menu` VALUES ('36', null, '0', '系统工具', null, '', '30', 'sys-tools', 'sys-tools', '\0', '\0', '\0', null, null, null, '2019-03-29 10:57:35', null);
INSERT INTO `sys_menu` VALUES ('37', '1', '1', '岗位管理', 'Job', 'system/job/index', '7', 'Steve-Jobs', 'job', '\0', '\0', '\0', 'job:list', null, null, '2019-03-29 13:51:18', null);
INSERT INTO `sys_menu` VALUES ('38', '36', '1', '接口文档', 'Swagger', 'tools/swagger/index', '36', 'swagger', 'swagger2', '\0', '\0', '\0', null, null, null, '2019-03-29 19:57:53', null);
INSERT INTO `sys_menu` VALUES ('39', '1', '1', '字典管理', 'Dict', 'system/dict/index', '8', 'dictionary', 'dict', '\0', '\0', '\0', 'dict:list', null, null, '2019-04-10 11:49:04', null);
INSERT INTO `sys_menu` VALUES ('41', '6', '1', '在线用户', 'OnlineUser', 'monitor/online/index', '10', 'Steve-Jobs', 'online', '\0', '\0', '\0', null, null, null, '2019-10-26 22:08:43', null);
INSERT INTO `sys_menu` VALUES ('44', '2', '2', '用户新增', null, '', '2', '', '', '\0', '\0', '\0', 'user:add', null, null, '2019-10-29 10:59:46', null);
INSERT INTO `sys_menu` VALUES ('45', '2', '2', '用户编辑', null, '', '3', '', '', '\0', '\0', '\0', 'user:edit', null, null, '2019-10-29 11:00:08', null);
INSERT INTO `sys_menu` VALUES ('46', '2', '2', '用户删除', null, '', '4', '', '', '\0', '\0', '\0', 'user:del', null, null, '2019-10-29 11:00:23', null);
INSERT INTO `sys_menu` VALUES ('48', '3', '2', '角色创建', null, '', '2', '', '', '\0', '\0', '\0', 'roles:add', null, null, '2019-10-29 12:45:34', null);
INSERT INTO `sys_menu` VALUES ('49', '3', '2', '角色修改', null, '', '3', '', '', '\0', '\0', '\0', 'roles:edit', null, null, '2019-10-29 12:46:16', null);
INSERT INTO `sys_menu` VALUES ('50', '3', '2', '角色删除', null, '', '4', '', '', '\0', '\0', '\0', 'roles:del', null, null, '2019-10-29 12:46:51', null);
INSERT INTO `sys_menu` VALUES ('52', '5', '2', '菜单新增', null, '', '2', '', '', '\0', '\0', '\0', 'menu:add', null, null, '2019-10-29 12:55:07', null);
INSERT INTO `sys_menu` VALUES ('53', '5', '2', '菜单编辑', null, '', '3', '', '', '\0', '\0', '\0', 'menu:edit', null, null, '2019-10-29 12:55:40', null);
INSERT INTO `sys_menu` VALUES ('54', '5', '2', '菜单删除', null, '', '4', '', '', '\0', '\0', '\0', 'menu:del', null, null, '2019-10-29 12:56:00', null);
INSERT INTO `sys_menu` VALUES ('56', '35', '2', '部门新增', null, '', '2', '', '', '\0', '\0', '\0', 'dept:add', null, null, '2019-10-29 12:57:09', null);
INSERT INTO `sys_menu` VALUES ('57', '35', '2', '部门编辑', null, '', '3', '', '', '\0', '\0', '\0', 'dept:edit', null, null, '2019-10-29 12:57:27', null);
INSERT INTO `sys_menu` VALUES ('58', '35', '2', '部门删除', null, '', '4', '', '', '\0', '\0', '\0', 'dept:del', null, null, '2019-10-29 12:57:41', null);
INSERT INTO `sys_menu` VALUES ('60', '37', '2', '岗位新增', null, '', '2', '', '', '\0', '\0', '\0', 'job:add', null, null, '2019-10-29 12:58:27', null);
INSERT INTO `sys_menu` VALUES ('61', '37', '2', '岗位编辑', null, '', '3', '', '', '\0', '\0', '\0', 'job:edit', null, null, '2019-10-29 12:58:45', null);
INSERT INTO `sys_menu` VALUES ('62', '37', '2', '岗位删除', null, '', '4', '', '', '\0', '\0', '\0', 'job:del', null, null, '2019-10-29 12:59:04', null);
INSERT INTO `sys_menu` VALUES ('64', '39', '2', '字典新增', null, '', '2', '', '', '\0', '\0', '\0', 'dict:add', null, null, '2019-10-29 13:00:17', null);
INSERT INTO `sys_menu` VALUES ('65', '39', '2', '字典编辑', null, '', '3', '', '', '\0', '\0', '\0', 'dict:edit', null, null, '2019-10-29 13:00:42', null);
INSERT INTO `sys_menu` VALUES ('66', '39', '2', '字典删除', null, '', '4', '', '', '\0', '\0', '\0', 'dict:del', null, null, '2019-10-29 13:00:59', null);
INSERT INTO `sys_menu` VALUES ('70', '16', '2', '图片上传', null, '', '2', '', '', '\0', '\0', '\0', 'pictures:add', null, null, '2019-10-29 13:05:34', null);
INSERT INTO `sys_menu` VALUES ('71', '16', '2', '图片删除', null, '', '3', '', '', '\0', '\0', '\0', 'pictures:del', null, null, '2019-10-29 13:05:52', null);
INSERT INTO `sys_menu` VALUES ('73', '28', '2', '任务新增', null, '', '2', '', '', '\0', '\0', '\0', 'timing:add', null, null, '2019-10-29 13:07:28', null);
INSERT INTO `sys_menu` VALUES ('74', '28', '2', '任务编辑', null, '', '3', '', '', '\0', '\0', '\0', 'timing:edit', null, null, '2019-10-29 13:07:41', null);
INSERT INTO `sys_menu` VALUES ('75', '28', '2', '任务删除', null, '', '4', '', '', '\0', '\0', '\0', 'timing:del', null, null, '2019-10-29 13:07:54', null);
INSERT INTO `sys_menu` VALUES ('77', '18', '2', '上传文件', null, '', '2', '', '', '\0', '\0', '\0', 'storage:add', null, null, '2019-10-29 13:09:09', null);
INSERT INTO `sys_menu` VALUES ('78', '18', '2', '文件编辑', null, '', '3', '', '', '\0', '\0', '\0', 'storage:edit', null, null, '2019-10-29 13:09:22', null);
INSERT INTO `sys_menu` VALUES ('79', '18', '2', '文件删除', null, '', '4', '', '', '\0', '\0', '\0', 'storage:del', null, null, '2019-10-29 13:09:34', null);
INSERT INTO `sys_menu` VALUES ('80', '6', '1', '服务监控', 'ServerMonitor', 'monitor/server/index', '14', 'codeConsole', 'server', '\0', '\0', '\0', 'monitor:list', null, 'admin', '2019-11-07 13:06:39', '2020-05-04 18:20:50');
INSERT INTO `sys_menu` VALUES ('82', '36', '1', '生成配置', 'GeneratorConfig', 'generator/config', '33', 'dev', 'generator/config/:tableName', '\0', '', '', '', null, null, '2019-11-17 20:08:56', null);
INSERT INTO `sys_menu` VALUES ('83', '10', '1', '图表库', 'Echarts', 'components/Echarts', '50', 'chart', 'echarts', '\0', '', '\0', '', null, null, '2019-11-21 09:04:32', null);
INSERT INTO `sys_menu` VALUES ('90', null, '1', '运维管理', 'Mnt', '', '20', 'mnt', 'mnt', '\0', '\0', '\0', null, null, null, '2019-11-09 10:31:08', null);
INSERT INTO `sys_menu` VALUES ('92', '90', '1', '服务器', 'ServerDeploy', 'mnt/server/index', '22', 'server', 'mnt/serverDeploy', '\0', '\0', '\0', 'serverDeploy:list', null, null, '2019-11-10 10:29:25', null);
INSERT INTO `sys_menu` VALUES ('93', '90', '1', '应用管理', 'App', 'mnt/app/index', '23', 'app', 'mnt/app', '\0', '\0', '\0', 'app:list', null, null, '2019-11-10 11:05:16', null);
INSERT INTO `sys_menu` VALUES ('94', '90', '1', '部署管理', 'Deploy', 'mnt/deploy/index', '24', 'deploy', 'mnt/deploy', '\0', '\0', '\0', 'deploy:list', null, null, '2019-11-10 15:56:55', null);
INSERT INTO `sys_menu` VALUES ('97', '90', '1', '部署备份', 'DeployHistory', 'mnt/deployHistory/index', '25', 'backup', 'mnt/deployHistory', '\0', '\0', '\0', 'deployHistory:list', null, null, '2019-11-10 16:49:44', null);
INSERT INTO `sys_menu` VALUES ('98', '90', '1', '数据库管理', 'Database', 'mnt/database/index', '26', 'database', 'mnt/database', '\0', '\0', '\0', 'database:list', null, null, '2019-11-10 20:40:04', null);
INSERT INTO `sys_menu` VALUES ('102', '97', '2', '删除', null, '', '999', '', '', '\0', '\0', '\0', 'deployHistory:del', null, null, '2019-11-17 09:32:48', null);
INSERT INTO `sys_menu` VALUES ('103', '92', '2', '服务器新增', null, '', '999', '', '', '\0', '\0', '\0', 'serverDeploy:add', null, null, '2019-11-17 11:08:33', null);
INSERT INTO `sys_menu` VALUES ('104', '92', '2', '服务器编辑', null, '', '999', '', '', '\0', '\0', '\0', 'serverDeploy:edit', null, null, '2019-11-17 11:08:57', null);
INSERT INTO `sys_menu` VALUES ('105', '92', '2', '服务器删除', null, '', '999', '', '', '\0', '\0', '\0', 'serverDeploy:del', null, null, '2019-11-17 11:09:15', null);
INSERT INTO `sys_menu` VALUES ('106', '93', '2', '应用新增', null, '', '999', '', '', '\0', '\0', '\0', 'app:add', null, null, '2019-11-17 11:10:03', null);
INSERT INTO `sys_menu` VALUES ('107', '93', '2', '应用编辑', null, '', '999', '', '', '\0', '\0', '\0', 'app:edit', null, null, '2019-11-17 11:10:28', null);
INSERT INTO `sys_menu` VALUES ('108', '93', '2', '应用删除', null, '', '999', '', '', '\0', '\0', '\0', 'app:del', null, null, '2019-11-17 11:10:55', null);
INSERT INTO `sys_menu` VALUES ('109', '94', '2', '部署新增', null, '', '999', '', '', '\0', '\0', '\0', 'deploy:add', null, null, '2019-11-17 11:11:22', null);
INSERT INTO `sys_menu` VALUES ('110', '94', '2', '部署编辑', null, '', '999', '', '', '\0', '\0', '\0', 'deploy:edit', null, null, '2019-11-17 11:11:41', null);
INSERT INTO `sys_menu` VALUES ('111', '94', '2', '部署删除', null, '', '999', '', '', '\0', '\0', '\0', 'deploy:del', null, null, '2019-11-17 11:12:01', null);
INSERT INTO `sys_menu` VALUES ('112', '98', '2', '数据库新增', null, '', '999', '', '', '\0', '\0', '\0', 'database:add', null, null, '2019-11-17 11:12:43', null);
INSERT INTO `sys_menu` VALUES ('113', '98', '2', '数据库编辑', null, '', '999', '', '', '\0', '\0', '\0', 'database:edit', null, null, '2019-11-17 11:12:58', null);
INSERT INTO `sys_menu` VALUES ('114', '98', '2', '数据库删除', null, '', '999', '', '', '\0', '\0', '\0', 'database:del', null, null, '2019-11-17 11:13:14', null);
INSERT INTO `sys_menu` VALUES ('116', '36', '1', '生成预览', 'Preview', 'generator/preview', '999', 'java', 'generator/preview/:tableName', '\0', '', '', null, null, null, '2019-11-26 14:54:36', null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `level` int(255) DEFAULT NULL COMMENT '角色级别',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `data_scope` varchar(255) DEFAULT NULL COMMENT '数据权限',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_name` (`name`),
  KEY `role_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', '1', '-', '全部', null, 'admin', '2018-11-23 11:04:37', '2020-05-05 11:24:24');
INSERT INTO `sys_role` VALUES ('2', '普通用户', '2', '-', '自定义', null, 'admin', '2018-11-23 13:09:06', '2020-05-10 12:32:52');

-- ----------------------------
-- Table structure for sys_roles_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_roles_menus`;
CREATE TABLE `sys_roles_menus` (
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`menu_id`,`role_id`) USING BTREE,
  KEY `FKcngg2qadojhi3a651a5adkvbq` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色菜单关联';

-- ----------------------------
-- Records of sys_roles_menus
-- ----------------------------
INSERT INTO `sys_roles_menus` VALUES ('1', '1');
INSERT INTO `sys_roles_menus` VALUES ('2', '1');
INSERT INTO `sys_roles_menus` VALUES ('3', '1');
INSERT INTO `sys_roles_menus` VALUES ('5', '1');
INSERT INTO `sys_roles_menus` VALUES ('6', '1');
INSERT INTO `sys_roles_menus` VALUES ('7', '1');
INSERT INTO `sys_roles_menus` VALUES ('9', '1');
INSERT INTO `sys_roles_menus` VALUES ('10', '1');
INSERT INTO `sys_roles_menus` VALUES ('11', '1');
INSERT INTO `sys_roles_menus` VALUES ('14', '1');
INSERT INTO `sys_roles_menus` VALUES ('15', '1');
INSERT INTO `sys_roles_menus` VALUES ('16', '1');
INSERT INTO `sys_roles_menus` VALUES ('18', '1');
INSERT INTO `sys_roles_menus` VALUES ('19', '1');
INSERT INTO `sys_roles_menus` VALUES ('21', '1');
INSERT INTO `sys_roles_menus` VALUES ('22', '1');
INSERT INTO `sys_roles_menus` VALUES ('23', '1');
INSERT INTO `sys_roles_menus` VALUES ('24', '1');
INSERT INTO `sys_roles_menus` VALUES ('27', '1');
INSERT INTO `sys_roles_menus` VALUES ('28', '1');
INSERT INTO `sys_roles_menus` VALUES ('30', '1');
INSERT INTO `sys_roles_menus` VALUES ('32', '1');
INSERT INTO `sys_roles_menus` VALUES ('33', '1');
INSERT INTO `sys_roles_menus` VALUES ('34', '1');
INSERT INTO `sys_roles_menus` VALUES ('35', '1');
INSERT INTO `sys_roles_menus` VALUES ('36', '1');
INSERT INTO `sys_roles_menus` VALUES ('37', '1');
INSERT INTO `sys_roles_menus` VALUES ('38', '1');
INSERT INTO `sys_roles_menus` VALUES ('39', '1');
INSERT INTO `sys_roles_menus` VALUES ('41', '1');
INSERT INTO `sys_roles_menus` VALUES ('44', '1');
INSERT INTO `sys_roles_menus` VALUES ('45', '1');
INSERT INTO `sys_roles_menus` VALUES ('46', '1');
INSERT INTO `sys_roles_menus` VALUES ('48', '1');
INSERT INTO `sys_roles_menus` VALUES ('49', '1');
INSERT INTO `sys_roles_menus` VALUES ('50', '1');
INSERT INTO `sys_roles_menus` VALUES ('52', '1');
INSERT INTO `sys_roles_menus` VALUES ('53', '1');
INSERT INTO `sys_roles_menus` VALUES ('54', '1');
INSERT INTO `sys_roles_menus` VALUES ('56', '1');
INSERT INTO `sys_roles_menus` VALUES ('57', '1');
INSERT INTO `sys_roles_menus` VALUES ('58', '1');
INSERT INTO `sys_roles_menus` VALUES ('60', '1');
INSERT INTO `sys_roles_menus` VALUES ('61', '1');
INSERT INTO `sys_roles_menus` VALUES ('62', '1');
INSERT INTO `sys_roles_menus` VALUES ('64', '1');
INSERT INTO `sys_roles_menus` VALUES ('65', '1');
INSERT INTO `sys_roles_menus` VALUES ('66', '1');
INSERT INTO `sys_roles_menus` VALUES ('73', '1');
INSERT INTO `sys_roles_menus` VALUES ('74', '1');
INSERT INTO `sys_roles_menus` VALUES ('75', '1');
INSERT INTO `sys_roles_menus` VALUES ('77', '1');
INSERT INTO `sys_roles_menus` VALUES ('78', '1');
INSERT INTO `sys_roles_menus` VALUES ('79', '1');
INSERT INTO `sys_roles_menus` VALUES ('80', '1');
INSERT INTO `sys_roles_menus` VALUES ('82', '1');
INSERT INTO `sys_roles_menus` VALUES ('83', '1');
INSERT INTO `sys_roles_menus` VALUES ('90', '1');
INSERT INTO `sys_roles_menus` VALUES ('92', '1');
INSERT INTO `sys_roles_menus` VALUES ('93', '1');
INSERT INTO `sys_roles_menus` VALUES ('94', '1');
INSERT INTO `sys_roles_menus` VALUES ('97', '1');
INSERT INTO `sys_roles_menus` VALUES ('98', '1');
INSERT INTO `sys_roles_menus` VALUES ('116', '1');
INSERT INTO `sys_roles_menus` VALUES ('1', '2');
INSERT INTO `sys_roles_menus` VALUES ('2', '2');
INSERT INTO `sys_roles_menus` VALUES ('3', '2');
INSERT INTO `sys_roles_menus` VALUES ('5', '2');
INSERT INTO `sys_roles_menus` VALUES ('6', '2');
INSERT INTO `sys_roles_menus` VALUES ('10', '2');
INSERT INTO `sys_roles_menus` VALUES ('14', '2');
INSERT INTO `sys_roles_menus` VALUES ('18', '2');
INSERT INTO `sys_roles_menus` VALUES ('19', '2');
INSERT INTO `sys_roles_menus` VALUES ('21', '2');
INSERT INTO `sys_roles_menus` VALUES ('23', '2');
INSERT INTO `sys_roles_menus` VALUES ('28', '2');
INSERT INTO `sys_roles_menus` VALUES ('30', '2');
INSERT INTO `sys_roles_menus` VALUES ('35', '2');
INSERT INTO `sys_roles_menus` VALUES ('36', '2');
INSERT INTO `sys_roles_menus` VALUES ('37', '2');
INSERT INTO `sys_roles_menus` VALUES ('38', '2');
INSERT INTO `sys_roles_menus` VALUES ('39', '2');
INSERT INTO `sys_roles_menus` VALUES ('44', '2');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `is_admin` bit(1) DEFAULT b'0' COMMENT '是否为admin账号',
  `enabled` bigint(20) DEFAULT NULL COMMENT '状态：1启用、0禁用',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新着',
  `pwd_reset_time` datetime DEFAULT NULL COMMENT '修改密码的时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UK_kpubos9gc2cvtkb0thktkbkes` (`email`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`),
  KEY `FKpq2dhypk2qgt68nauh2by22jb` (`avatar`) USING BTREE,
  KEY `inx_enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '18888888888', '201507802@qq.com', null, '$2a$10$Egp1/gvFlt7zhlXVfEFw4OfWQCGPw0ClmMcc6FjTnvXNRVf9zdMRa', '', '1', null, 'admin', '2020-05-03 16:38:31', '2018-08-23 09:11:56', '2020-05-05 10:12:21');

-- ----------------------------
-- Table structure for sys_users_roles
-- ----------------------------
DROP TABLE IF EXISTS `sys_users_roles`;
CREATE TABLE `sys_users_roles` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `FKq4eq273l04bpu4efj0jd0jb98` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户角色关联';

-- ----------------------------
-- Records of sys_users_roles
-- ----------------------------
INSERT INTO `sys_users_roles` VALUES ('1', '1');
INSERT INTO `sys_users_roles` VALUES ('1', '2');

-- ----------------------------
-- Table structure for web_log
-- ----------------------------
DROP TABLE IF EXISTS `web_log`;
CREATE TABLE `web_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text COMMENT '操作描述',
  `username` varchar(64) DEFAULT NULL COMMENT '操作用户',
  `start_time` bigint(20) DEFAULT NULL COMMENT '操作时间',
  `spend_time` int(11) DEFAULT NULL COMMENT '消耗时间',
  `base_path` varchar(64) DEFAULT NULL COMMENT '根路径',
  `uri` varchar(64) DEFAULT NULL COMMENT 'URI',
  `url` varchar(64) DEFAULT NULL COMMENT 'URL',
  `method` varchar(64) DEFAULT NULL COMMENT '请求类型',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `parameter` text COMMENT '请求参数',
  `result` text COMMENT '返回结果',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8 COMMENT='操作日志';

-- ----------------------------
-- Records of web_log
-- ----------------------------
