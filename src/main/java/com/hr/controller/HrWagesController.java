package com.hr.controller;

import com.hr.entity.HrWages;
import com.hr.entity.PageBean;
import com.hr.service.HrWagesService;
import com.hr.util.DateJsonValueProcessor;
import com.hr.util.JSONMap;
import com.hr.util.ResponseUtil;
import com.hr.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("hrWages")
public class HrWagesController {

    @Resource
    private HrWagesService hrWagesService;

    /**yyyy-MM-dd格式字符串转Date*/
    @InitBinder
    public void initBinder(ServletRequestDataBinder binder){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 无参数查询所有工资信息列表
     */
    @RequestMapping("/countList")
    public String countList(HttpServletResponse response) throws Exception {
        //查询工资信息列表
        List<HrWages> hrWagesList = hrWagesService.countList();
        //将数据写入response
        JSONMap result = new JSONMap();
        JSONArray jsonArray = JSONArray.fromObject(hrWagesList);
        result.put("rows", jsonArray);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 带参数查询工资信息列表
     */
    @RequestMapping("/list")
    public String list(HrWages hrWages,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if(page != null && page != "" && rows != null && rows != "") {
            PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        map.put("id", hrWages.getId());
        if(hrWages.getHrFiles() != null) map.put("filesId", hrWages.getHrFiles().getId());
        map.put("dateStr", StringUtil.formatLike(hrWages.getDateStr()));
        //查询工资信息列表
        List<HrWages> hrWagesList = hrWagesService.list(map);
        //查询总共有多少条数据
        Long total = hrWagesService.getTotal(map);
        //将数据写入response
        JSONMap result = new JSONMap();
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(hrWagesList, config);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 查询一条工资信息
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id")String id, HttpServletResponse response) throws Exception {
        HrWages hrWages = hrWagesService.findById(Integer.parseInt(id));
        //将数据写入response
        JSONObject result = new JSONObject(hrWages);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加或修改一条工资信息
     */
    @RequestMapping("/save")
    public String save(HrWages hrWages, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if(hrWages.getId() == null) {
            //添加
            resultTotal = hrWagesService.add(hrWages);
        } else {
            //修改
            resultTotal = hrWagesService.update(hrWages);
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
     * 删除工资信息
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            hrWagesService.delete(Integer.parseInt(id));
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }

}
