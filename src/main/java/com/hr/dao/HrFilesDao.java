package com.hr.dao;

import com.hr.entity.HrFiles;

import java.util.List;
import java.util.Map;

public interface HrFilesDao {

    /**无参数查询所有档案*/
    public List<HrFiles> countList();

    /**带参数查询档案列表*/
    public List<HrFiles> list(Map<String,Object> map);

    /**根据主键查询一份档案*/
    public HrFiles findById(Integer id);

    /**带参数查询档案数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份档案*/
    public Integer add(HrFiles hrFiles);

    /**修改一份档案*/
    public Integer update(HrFiles hrFiles);

    /**根据主键删除一份档案*/
    public Integer delete(Integer id);

}
