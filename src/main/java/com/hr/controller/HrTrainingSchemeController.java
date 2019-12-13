package com.hr.controller;

import com.hr.entity.HrTrainingScheme;
import com.hr.entity.PageBean;
import com.hr.service.HrTrainingSchemeService;
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
@RequestMapping("/hrTrainingScheme")
public class HrTrainingSchemeController {
    
    @Resource
    private HrTrainingSchemeService hrTrainingSchemeService;

    /**yyyy-MM-dd格式字符串转Date*/
    @InitBinder
    public void initBinder(ServletRequestDataBinder binder){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 无参数查询所有培训方案列表
     */
    @RequestMapping("/countList")
    public String countList(HttpServletResponse response) throws Exception {
        //查询培训方案列表
        List<HrTrainingScheme> hrTrainingSchemeList = hrTrainingSchemeService.countList();
        //将数据写入response
        JSONMap result = new JSONMap();
        JSONArray jsonArray = JSONArray.fromObject(hrTrainingSchemeList);
        result.put("rows", jsonArray);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 带参数查询培训方案列表
     */
    @RequestMapping("/list")
    public String list(HrTrainingScheme hrTrainingScheme,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if(page != null && page != "" && rows != null && rows != "") {
            PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        map.put("id", hrTrainingScheme.getId());
        map.put("content", StringUtil.formatLike(hrTrainingScheme.getContent()));
        map.put("startDateStr", StringUtil.formatLike(hrTrainingScheme.getStartDateStr()));
        map.put("endDateStr", StringUtil.formatLike(hrTrainingScheme.getEndDateStr()));
        map.put("isPass", hrTrainingScheme.getIsPass());
        //查询培训方案列表
        List<HrTrainingScheme> hrTrainingSchemeList = hrTrainingSchemeService.list(map);
        //查询总共有多少条数据
        Long total = hrTrainingSchemeService.getTotal(map);
        //将数据写入response
        JSONMap result = new JSONMap();
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(hrTrainingSchemeList, config);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 查询一份培训方案
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id")String id, HttpServletResponse response) throws Exception {
        HrTrainingScheme hrTrainingScheme = hrTrainingSchemeService.findById(Integer.parseInt(id));
        //将数据写入response
        JSONObject result = new JSONObject(hrTrainingScheme);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加或修改一份培训方案
     */
    @RequestMapping("/save")
    public String save(HrTrainingScheme hrTrainingScheme, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if(hrTrainingScheme.getId() == null) {
            //添加
            resultTotal = hrTrainingSchemeService.add(hrTrainingScheme);
        } else {
            //修改
            resultTotal = hrTrainingSchemeService.update(hrTrainingScheme);
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
     * 删除培训方案
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            hrTrainingSchemeService.delete(Integer.parseInt(id));
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }
    
}
