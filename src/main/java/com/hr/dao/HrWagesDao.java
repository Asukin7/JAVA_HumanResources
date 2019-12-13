package com.hr.dao;

import com.hr.entity.HrWages;

import java.util.List;
import java.util.Map;

public interface HrWagesDao {

    /**无参数查询所有工资信息列表*/
    public List<HrWages> countList();

    /**带参数查询工资信息列表*/
    public List<HrWages> list(Map<String,Object> map);

    /**根据主键查询一条工资信息*/
    public HrWages findById(Integer id);

    /**带参数查询工资信息数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一条工资信息*/
    public Integer add(HrWages hrWages);

    /**修改一条工资信息*/
    public Integer update(HrWages hrWages);

    /**根据主键删除一条工资信息*/
    public Integer delete(Integer id);

}
