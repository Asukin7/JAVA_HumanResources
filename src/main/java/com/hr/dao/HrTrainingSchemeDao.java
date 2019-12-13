package com.hr.dao;

import com.hr.entity.HrTrainingScheme;

import java.util.List;
import java.util.Map;

public interface HrTrainingSchemeDao {
    
    /**无参数查询所有培训方案列表*/
    public List<HrTrainingScheme> countList();

    /**带参数查询培训方案列表*/
    public List<HrTrainingScheme> list(Map<String,Object> map);

    /**根据主键查询一份培训方案*/
    public HrTrainingScheme findById(Integer id);

    /**带参数查询培训方案数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份培训方案*/
    public Integer add(HrTrainingScheme hrTrainingScheme);

    /**修改一份培训方案*/
    public Integer update(HrTrainingScheme hrTrainingScheme);

    /**根据主键删除一份培训方案*/
    public Integer delete(Integer id);

}
