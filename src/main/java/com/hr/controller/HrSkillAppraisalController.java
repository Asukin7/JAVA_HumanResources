package com.hr.controller;

import com.hr.entity.HrSkillAppraisal;
import com.hr.entity.PageBean;
import com.hr.service.HrSkillAppraisalService;
import com.hr.util.DateJsonValueProcessor;
import com.hr.util.JSONMap;
import com.hr.util.ResponseUtil;
import com.hr.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/hrSkillAppraisal")
public class HrSkillAppraisalController {

    @Resource
    private HrSkillAppraisalService hrSkillAppraisalService;

    /**
     * 无参数查询所有技能鉴定列表
     */
    @RequestMapping("/countList")
    public String countList(HttpServletResponse response) throws Exception {
        //查询技能鉴定列表
        List<HrSkillAppraisal> HrSkillAppraisalList = hrSkillAppraisalService.countList();
        //将数据写入response
        JSONMap result = new JSONMap();
        JSONArray jsonArray = JSONArray.fromObject(HrSkillAppraisalList);
        result.put("rows", jsonArray);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 带参数查询技能鉴定列表
     */
    @RequestMapping("/list")
    public String list(HrSkillAppraisal hrSkillAppraisal,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if(page != null && page != "" && rows != null && rows != "") {
            PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        map.put("id", hrSkillAppraisal.getId());
        if(hrSkillAppraisal.getHrFiles() != null) map.put("filesId", hrSkillAppraisal.getHrFiles().getId());
        map.put("content", StringUtil.formatLike(hrSkillAppraisal.getContent()));
        map.put("submitDateStr", StringUtil.formatLike(hrSkillAppraisal.getSubmitDateStr()));
        map.put("isPass", hrSkillAppraisal.getIsPass());
        map.put("auditDateStr", StringUtil.formatLike(hrSkillAppraisal.getAuditDateStr()));
        //查询技能鉴定列表
        List<HrSkillAppraisal> hrSkillAppraisalList = hrSkillAppraisalService.list(map);
        //查询总共有多少条数据
        Long total = hrSkillAppraisalService.getTotal(map);
        //将数据写入response
        JSONMap result = new JSONMap();
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(hrSkillAppraisalList, config);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 查询一份技能鉴定
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id")String id, HttpServletResponse response) throws Exception {
        HrSkillAppraisal hrSkillAppraisal = hrSkillAppraisalService.findById(Integer.parseInt(id));
        //将数据写入response
        JSONObject result = new JSONObject(hrSkillAppraisal);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加或修改一份技能鉴定
     */
    @RequestMapping("/save")
    public String save(HrSkillAppraisal hrSkillAppraisal, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if(hrSkillAppraisal.getId() == null) {
            //添加
            resultTotal = hrSkillAppraisalService.add(hrSkillAppraisal);
        } else {
            //修改
            resultTotal = hrSkillAppraisalService.update(hrSkillAppraisal);
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
     * 删除技能鉴定
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            hrSkillAppraisalService.delete(Integer.parseInt(id));
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }

}
