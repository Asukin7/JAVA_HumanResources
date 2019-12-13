package com.hr.controller;

import com.hr.entity.HrPostTransfer;
import com.hr.entity.PageBean;
import com.hr.service.HrPostTransferService;
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
@RequestMapping("/hrPostTransfer")
public class HrPostTransferController {

    @Resource
    private HrPostTransferService hrPostTransferService;

    /**
     * 无参数查询所有岗位调动列表
     */
    @RequestMapping("/countList")
    public String countList(HttpServletResponse response) throws Exception {
        //查询岗位调动列表
        List<HrPostTransfer> hrPostTransferList = hrPostTransferService.countList();
        //将数据写入response
        JSONMap result = new JSONMap();
        JSONArray jsonArray = JSONArray.fromObject(hrPostTransferList);
        result.put("rows", jsonArray);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 带参数查询岗位调动列表
     */
    @RequestMapping("/list")
    public String list(HrPostTransfer hrPostTransfer,
                       @RequestParam(value = "page", required = false)String page,
                       @RequestParam(value = "rows", required = false)String rows,
                       HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if(page != null && page != "" && rows != null && rows != "") {
            PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        map.put("id", hrPostTransfer.getId());
        if(hrPostTransfer.getHrFiles() != null) map.put("filesId", hrPostTransfer.getHrFiles().getId());
        map.put("content", StringUtil.formatLike(hrPostTransfer.getContent()));
        map.put("submitDateStr", StringUtil.formatLike(hrPostTransfer.getSubmitDateStr()));
        map.put("isPass", hrPostTransfer.getIsPass());
        map.put("auditDateStr", StringUtil.formatLike(hrPostTransfer.getAuditDateStr()));
        //查询岗位调动列表
        List<HrPostTransfer> hrPostTransferList = hrPostTransferService.list(map);
        //查询总共有多少条数据
        Long total = hrPostTransferService.getTotal(map);
        //将数据写入response
        JSONMap result = new JSONMap();
        JsonConfig config = new JsonConfig();
        config.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
        JSONArray jsonArray = JSONArray.fromObject(hrPostTransferList, config);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 查询一份岗位调动
     */
    @RequestMapping("/findById")
    public String findById(@RequestParam("id")String id, HttpServletResponse response) throws Exception {
        HrPostTransfer hrPostTransfer = hrPostTransferService.findById(Integer.parseInt(id));
        //将数据写入response
        JSONObject result = new JSONObject(hrPostTransfer);
        ResponseUtil.write(response, result);
        return null;
    }

    /**
     * 添加或修改一份岗位调动
     */
    @RequestMapping("/save")
    public String save(HrPostTransfer hrPostTransfer, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        if(hrPostTransfer.getId() == null) {
            //添加
            resultTotal = hrPostTransferService.add(hrPostTransfer);
        } else {
            //修改
            resultTotal = hrPostTransferService.update(hrPostTransfer);
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
     * 删除岗位调动
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("ids")String ids, HttpServletResponse response) throws Exception {
        String[] idsStr = ids.split(",");
        for (String id : idsStr) {
            hrPostTransferService.delete(Integer.parseInt(id));
        }
        JSONObject result = new JSONObject();
        result.put("success", Boolean.valueOf("true"));
        ResponseUtil.write(response, result);
        return null;
    }

}
