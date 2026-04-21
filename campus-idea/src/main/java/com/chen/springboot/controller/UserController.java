package com.chen.springboot.controller;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.javamail.JavaMailSender;
import java.util.concurrent.TimeUnit;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.chen.springboot.common.Constants;
import com.chen.springboot.common.Result;
import com.chen.springboot.controller.dto.UserDTO;
import com.chen.springboot.controller.dto.UserPasswordDTO;
import com.chen.springboot.entity.User;
import com.chen.springboot.service.IUserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author GoatCode
 * @since 2024-01-26
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Value("${files.upload.path}")
    private String filesUploadPath;

    @Resource
    private IUserService userService;

    @Resource
    private RedisTemplate<String, String> redisTemplate;

    @Resource
    private JavaMailSender javaMailSender;

    @PostMapping("/login")
    public Result login(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        UserDTO dto = userService.login(userDTO);
        return Result.success(dto);
    }

    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
        String email = userDTO.getEmail();
        String code = userDTO.getCode();

        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            return Result.error(Constants.CODE_400, "参数错误");
        }
        return Result.success(userService.register(userDTO));
    }

    // ====================== 发送验证码（已填入你的Gmail） ======================
    @PostMapping("/sendCode")
    public Result sendCode(@RequestBody UserDTO userDTO) {
        String email = userDTO.getEmail();

        // 生成6位验证码
        int code = (int) ((Math.random() * 9 + 1) * 100000);
        String codeStr = String.valueOf(code);

        // 存入Redis 5分钟
        redisTemplate.opsForValue().set("REGISTER_CODE:" + email, codeStr, 5, TimeUnit.MINUTES);

        try {
            // 发送漂亮的HTML邮件
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            // 👇 这里已经填好你的邮箱
            helper.setFrom("internetdzuka30234@gmail.com", "曦岳平台");
            helper.setTo(email);
            helper.setSubject("【曦岳平台】注册验证码");

            // ====================== 邮件样式（可随便改颜色、文字） ======================
            String html = "<div style='max-width:600px;margin:30px auto;padding:36px;border-radius:20px;background:#1A1D23;font-family:-apple-system, BlinkMacSystemFont, \"Microsoft YaHei\", sans-serif;box-shadow:0 8px 30px rgba(0,0,0,0.2);'>"
                + "<div style='text-align:center;margin-bottom:28px;'>"
                + "<h2 style='color:#E9EAEC;margin:0;font-size:22px;font-weight:600;'>曦岳论坛平台 账号注册验证</h2>"
                + "</div>"
                + "<p style='color:#B0B4B9;font-size:15px;line-height:1.7;margin:0 0 22px 0;'>您好，感谢您注册曦岳平台。为保障您的账号安全，请完成邮箱验证。</p>"
                + "<div style='padding:22px;border-radius:16px;background:rgba(255,255,255,0.08);backdrop-filter:blur(10px);-webkit-backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,0.1);text-align:center;margin:26px 0;'>"
                + "<p style='color:#8A8D91;font-size:14px;margin:0 0 10px 0;'>您的验证码</p>"
                + "<span style='font-size:32px;font-weight:700;letter-spacing:8px;color:#000000;'>" + codeStr + "</span>"
                + "</div>"
                + "<p style='color:#8A8D91;font-size:14px;line-height:1.6;margin:0 0 10px 0;'>· 验证码 5 分钟内有效</p>"
                + "<p style='color:#8A8D91;font-size:14px;line-height:1.6;margin:0;'>· 请勿向他人泄露此验证码</p>"
                + "<div style='margin-top:36px;padding-top:20px;border-top:1px solid rgba(255,255,255,0.07);text-align:right;'>"
                + "<p style='color:#6E7277;font-size:13px;margin:0;'>曦岳论坛平台</p>"
                + "</div>"
                + "</div>";
            // ==========================================================================

            helper.setText(html, true);
            javaMailSender.send(message);

            return Result.success("验证码发送成功");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error(Constants.CODE_500, "发送失败，请检查邮箱配置");
        }
    }

    // 新增或者更新
    @PostMapping
    public Result save(@RequestBody User user) {
        if (user.getId() == null && user.getPassword() == null) {  // 新增用户默认密码
            user.setPassword( SecureUtil.md5("123"));
        }
        return Result.success(userService.saveOrUpdate(user));
    }

    /**
     * 修改密码
     * @param userPasswordDTO
     * @return
     */
    @PostMapping("/password")
    public Result password(@RequestBody UserPasswordDTO userPasswordDTO) {
        userPasswordDTO.setPassword(SecureUtil.md5(userPasswordDTO.getPassword()));
        userPasswordDTO.setNewPassword(SecureUtil.md5(userPasswordDTO.getNewPassword()));
        userService.updatePassword(userPasswordDTO);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(userService.removeById(id));
    }

    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(userService.removeByIds(ids));
    }

    @GetMapping
    public Result findAll() {
        return Result.success(userService.list());
    }

    @GetMapping("/role/{role}")   //角色
    public Result findUsersByRole(@PathVariable String role) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("role", role);
        List<User> list = userService.list(queryWrapper);
        return Result.success(list);
    }

    @GetMapping("/{id}")
    public Result findOne(@PathVariable Integer id) {
        return Result.success(userService.getById(id));
    }

    @GetMapping("/username/{username}")
    public Result findByUsername(@PathVariable String username) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        return Result.success(userService.getOne(queryWrapper));
    }

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                               @RequestParam Integer pageSize,
                               @RequestParam(defaultValue = "") String username,
                               @RequestParam(defaultValue = "") String email,
                               @RequestParam(defaultValue = "") String address) {

        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        if (!"".equals(username)) {
            queryWrapper.like("username", username);
        }
        if (!"".equals(email)) {
            queryWrapper.like("email", email);
        }
        if (!"".equals(address)) {
            queryWrapper.like("address", address);
        }

        return Result.success(userService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    /**
     * 导出接口
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<User> list = userService.list();
        // 通过工具类创建writer 写出到磁盘路径
//        ExcelWriter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xlsx");
        // 在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("username", "用户名");
        writer.addHeaderAlias("password", "密码");
        writer.addHeaderAlias("nickname", "昵称");
        writer.addHeaderAlias("email", "邮箱");
        writer.addHeaderAlias("phone", "电话");
        writer.addHeaderAlias("address", "地址");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("avatarUrl", "头像");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("用户信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

    }

    /**
     * excel 导入
     * @param file
     * @throws Exception
     */
    @PostMapping("/import")
    public Result imp(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();
        ExcelReader reader = ExcelUtil.getReader(inputStream);
        // 方式1：(推荐) 通过 javabean的方式读取Excel内的对象，但是要求表头必须是英文，跟javabean的属性要对应起来
//        List<User> list = reader.readAll(User.class);

        // 方式2：忽略表头的中文，直接读取表的内容
        List<List<Object>> list = reader.read(1);
        List<User> users = CollUtil.newArrayList();
        for (List<Object> row : list) {
            User user = new User();
            user.setUsername(row.get(0).toString());
            user.setPassword(row.get(1).toString());
            user.setNickname(row.get(2).toString());
            user.setEmail(row.get(3).toString());
            user.setPhone(row.get(4).toString());
            user.setAddress(row.get(5).toString());
            user.setAvatarUrl(row.get(6).toString());
            users.add(user);
        }

        userService.saveBatch(users);
        return Result.success(true);
    }

}