package com.hr.controller;

import com.hr.entity.HrDepartment;
import com.hr.entity.PageBean;
import com.hr.service.HrDepartmentService;
import com.hr.util.ResponseUtil;
import com.hr.util.StringUtil;
import net.sf.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/hrDepartment")
public class HrDepartmentController {

    @Resource
    private HrDepartmentService hrDepartmentService;

    /**
     * 无参数查询所有部门列表
     */
    @RequestMapping("/countList")
    public String countList(HttpServletResponse response) throws Exception {
        //查询部门列表
        List<HrDepartment> hrDepartmentList = hrDepartmentService.countList();
        //将数据写入response
        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(hrDepartmentList);
        result.put("rows", jsonArray);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 带参数查询部门列表
     */
    @RequestMapping("/list")
    public String list(HrDepartment hrDepartment,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("name", StringUtil.formatLike(hrDepartment.getName()));
        //查询部门列表
        List<HrDepartment> hrDepartmentList = hrDepartmentService.list(map);
        //查询总共有多少条数据
        Long total = hrDepartmentService.getTotal(map);
        //将数据写入response
        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(hrDepartmentList);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 查询一个部门信息
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id")String id, HttpServletResponse response) throws Exception {
        HrDepartment hrDepartment = hrDepartmentService.findById(Integer.parseInt(id));
        //将数据写入response
        JSONObject result = new JSONObject(hrDepartment);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加或修改一个部门信息
     */
    @RequestMapping("/save")
    public String save(HrDepartment hrDepartment, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if(hrDepartment.getId() == null) {
            //添加
            resultTotal = hrDepartmentService.add(hrDepartment);
        } else {
            //修改
            resultTotal = hrDepartmentService.update(hrDepartment);
        }
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
     * 删除部门信息
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            hrDepartmentService.delete(Integer.parseInt(id));
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }

}
