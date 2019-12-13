package com.hr.dao;

import com.hr.entity.HrDepartment;

import java.util.List;
import java.util.Map;

public interface HrDepartmentDao {

    /**无参数查询所有部门列表*/
    public List<HrDepartment> countList();

    /**带参数查询部门列表*/
    public List<HrDepartment> list(Map<String,Object> map);

    /**根据主键查询一个部门*/
    public HrDepartment findById(Integer id);

    /**带参数查询部门数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一个部门*/
    public Integer add(HrDepartment hrDepartment);

    /**修改一个部门*/
    public Integer update(HrDepartment hrDepartment);

    /**根据主键删除一个部门*/
    public Integer delete(Integer id);

}
