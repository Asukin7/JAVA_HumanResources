package com.hr.dao;

import com.hr.entity.HrDepartmentBonus;

import java.util.List;
import java.util.Map;

public interface HrDepartmentBonusDao {

    /**无参数查询所有部门奖金列表*/
    public List<HrDepartmentBonus> countList();

    /**带参数查询部门奖金列表*/
    public List<HrDepartmentBonus> list(Map<String,Object> map);

    /**根据主键查询一份部门奖金*/
    public HrDepartmentBonus findById(Integer id);

    /**带参数查询部门奖金数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份部门奖金*/
    public Integer add(HrDepartmentBonus hrDepartmentBonus);

    /**修改一份部门奖金*/
    public Integer update(HrDepartmentBonus hrDepartmentBonus);

    /**根据主键删除一份部门奖金*/
    public Integer delete(Integer id);

}
