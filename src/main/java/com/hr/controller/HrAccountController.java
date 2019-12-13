package com.hr.controller;

import com.hr.entity.HrAccount;
import com.hr.entity.PageBean;
import com.hr.service.HrAccountService;
import com.hr.util.CryptographyUtil;
import com.hr.util.ResponseUtil;
import net.sf.json.JSONArray;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/hrAccount")
public class HrAccountController {

    @Resource
    HrAccountService hrAccountService;

    @RequestMapping("/login")
    public String login(HrAccount hrAccount, HttpServletRequest request) {
        /**账号*/
        String account = hrAccount.getAccount();
        /**密码*/
        String password = hrAccount.getPassword();
        String passwordMd5 = CryptographyUtil.md5(password, "123456");
        /**Subject*/
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(account, passwordMd5);
        try {
            //传递token给shiro的realm
            subject.login(usernamePasswordToken);
            return "redirect:/admin/main.jsp";
        } catch (AuthenticationException e) {
            e.printStackTrace();
            request.setAttribute("HrAccount", hrAccount);
            request.setAttribute("errorInfo", "用户名或密码错误！");
        }
        return "index";
    }

    /**
     * 修改密码
     */
    @RequestMapping({"/modifyPassword"})
    public String modifyPassword(@RequestParam("account")String account, @RequestParam("newPassword")String newPassword, HttpServletResponse response) throws Exception {
        HrAccount hrAccount = new HrAccount();
        hrAccount.setAccount(account);
        hrAccount.setPassword(CryptographyUtil.md5(newPassword,"123456"));
        int resultTotal = hrAccountService.update(hrAccount);
        JSONObject result = new JSONObject();
        if(resultTotal>0) {
            result.put("success", Boolean.TRUE);
        }else {
            result.put("success", Boolean.FALSE);
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 用户退出
     */
    @RequestMapping({"/logout"})
    public String logout() {
        SecurityUtils.getSubject().logout();
        return "redirect:/index.jsp";
    }

    /**
     * 查询账号列表
     */
    @RequestMapping("/list")
    public String list(HrAccount hrAccount,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if(page != null && page != "" && rows != null && rows != "") {
            PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        //查询账号列表
        List<HrAccount> hrAccountList = hrAccountService.list(map);
        //查询总共有多少条数据
        Long total = hrAccountService.getTotal(map);
        //将数据写入response
        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(hrAccountList);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加一个账号信息
     */
    @RequestMapping("/add")
    public String add(HrAccount hrAccount, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        hrAccount.setPassword(CryptographyUtil.md5("123456","123456"));
        resultTotal = hrAccountService.add(hrAccount);
        JSONObject result = new JSONObject();
        if(resultTotal > 0) {
            result.put("success", Boolean.valueOf(true));
        } else {
            result.put("success", Boolean.valueOf(false));
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 修改一个账号信息
     */
    @RequestMapping("/update")
    public String update(HrAccount hrAccount, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        resultTotal = hrAccountService.update(hrAccount);
        JSONObject result = new JSONObject();
        if(resultTotal > 0) {
            result.put("success", Boolean.valueOf(true));
        } else {
            result.put("success", Boolean.valueOf(false));
        }
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 删除账号信息
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            HrAccount hrAccount = new HrAccount();
            hrAccount.setAccount(id);
            hrAccountService.delete(hrAccount);
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }

}
