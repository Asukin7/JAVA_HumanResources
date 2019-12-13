package com.hr.dao;

import com.hr.entity.HrTrainingSchemeFiles;

import java.util.List;
import java.util.Map;

public interface HrTrainingSchemeFilesDao {

    /**带参数查询培训方案档案关系列表*/
    public List<HrTrainingSchemeFiles> list(Map<String,Object> map);

    /**带参数查询培训方案档案关系数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份培训方案档案关系*/
    public Integer add(HrTrainingSchemeFiles hrTrainingSchemeFiles);

    /**删除一份培训方案档案关系*/
    public Integer delete(HrTrainingSchemeFiles hrTrainingSchemeFiles);

}
