package com.hr.dao;

import com.hr.entity.HrContract;

import java.util.List;
import java.util.Map;

public interface HrContractDao {

    /**无参数查询所有合同列表*/
    public List<HrContract> countList();

    /**带参数查询合同列表*/
    public List<HrContract> list(Map<String,Object> map);

    /**根据主键查询一份合同*/
    public HrContract findById(Integer id);

    /**带参数查询合同数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份合同*/
    public Integer add(HrContract hrContract);

    /**修改一份合同*/
    public Integer update(HrContract hrContract);

    /**根据主键删除一份合同*/
    public Integer delete(Integer id);

}
