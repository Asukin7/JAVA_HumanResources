package com.hr.controller;

import com.hr.entity.HrTrainingSchemeFiles;
import com.hr.entity.PageBean;
import com.hr.service.HrTrainingSchemeFilesService;
import com.hr.util.ResponseUtil;
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
@RequestMapping("/hrTrainingSchemeFiles")
public class HrTrainingSchemeFilesController {

    @Resource
    private HrTrainingSchemeFilesService hrTrainingSchemeFilesService;

    /**
     * 带参数查询培训方案档案关系列表
     */
    @RequestMapping("/list")
    public String list(HrTrainingSchemeFiles hrTrainingSchemeFiles,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("start", pageBean.getStart());
        map.put("size", pageBean.getPageSize());
        map.put("hrTrainingSchemeID", hrTrainingSchemeFiles.getHrTrainingSchemeID());
        //查询培训方案档案关系列表
        List<HrTrainingSchemeFiles> hrTrainingSchemeFilesList = hrTrainingSchemeFilesService.list(map);
        //查询总共有多少条数据
        Long total = hrTrainingSchemeFilesService.getTotal(map);
        //将数据写入response
        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(hrTrainingSchemeFilesList);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加一份培训方案档案关系信息
     */
    @RequestMapping("/save")
    public String save(HrTrainingSchemeFiles hrTrainingSchemeFiles, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        resultTotal = hrTrainingSchemeFilesService.add(hrTrainingSchemeFiles);
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
     * 删除一份培训方案档案关系信息
     */
    @RequestMapping("/delete")
    public String delete(HrTrainingSchemeFiles hrTrainingSchemeFiles, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        resultTotal = hrTrainingSchemeFilesService.delete(hrTrainingSchemeFiles);
        JSONObject result = new JSONObject();
        if(resultTotal > 0) {
            result.put("success", Boolean.valueOf(true));
        } else {
            result.put("success", Boolean.valueOf(false));
        }
        ResponseUtil.write(response, result);
        return null;
    }

}
