package com.hr.controller;

import com.hr.entity.HrContract;
import com.hr.entity.PageBean;
import com.hr.service.HrContractService;
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
@RequestMapping("/hrContract")
public class HrContractController {

    @Resource
    private HrContractService hrContractService;

    /**yyyy-MM-dd格式字符串转Date*/
    @InitBinder
    public void initBinder(ServletRequestDataBinder binder){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 无参数查询所有合同列表
     */
    @RequestMapping("/countList")
    public String countList(HttpServletResponse response) throws Exception {
        //查询合同列表
        List<HrContract> hrContractList = hrContractService.countList();
        //将数据写入response
        JSONMap result = new JSONMap();
        JSONArray jsonArray = JSONArray.fromObject(hrContractList);
        result.put("rows", jsonArray);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 带参数查询合同列表
     */
    @RequestMapping("/list")
    public String list(HrContract hrContract,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if(page != null && page != "" && rows != null && rows != "") {
            PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        map.put("id", hrContract.getId());
        if(hrContract.getHrFiles() != null) map.put("filesId", hrContract.getHrFiles().getId());
        map.put("content", StringUtil.formatLike(hrContract.getContent()));
        map.put("startDateStr", StringUtil.formatLike(hrContract.getStartDateStr()));
        map.put("endDateStr", StringUtil.formatLike(hrContract.getEndDateStr()));
        //查询合同列表
        List<HrContract> hrContractList = hrContractService.list(map);
        //查询总共有多少条数据
        Long total = hrContractService.getTotal(map);
        //将数据写入response
        JSONMap result = new JSONMap();
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(hrContractList, config);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 查询一份合同
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id")String id, HttpServletResponse response) throws Exception {
        HrContract hrContract = hrContractService.findById(Integer.parseInt(id));
        //将数据写入response
        JSONObject result = new JSONObject(hrContract);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加或修改一份合同
     */
    @RequestMapping("/save")
    public String save(HrContract hrContract, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if(hrContract.getId() == null) {
            //添加
            resultTotal = hrContractService.add(hrContract);
        } else {
            //修改
            resultTotal = hrContractService.update(hrContract);
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
     * 删除合同
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            hrContractService.delete(Integer.parseInt(id));
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }

}
