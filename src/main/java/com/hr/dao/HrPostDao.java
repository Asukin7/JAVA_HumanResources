package com.hr.dao;

import com.hr.entity.HrPost;

import java.util.List;
import java.util.Map;

public interface HrPostDao {

    /**无参数查询所有岗位列表*/
    public List<HrPost> countList();

    /**带参数查询岗位列表*/
    public List<HrPost> list(Map<String,Object> map);

    /**根据主键查询一个岗位*/
    public HrPost findById(Integer id);

    /**带参数查询岗位数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一个岗位*/
    public Integer add(HrPost hrPost);

    /**修改一个岗位*/
    public Integer update(HrPost hrPost);

    /**根据主键删除一个岗位*/
    public Integer delete(Integer id);

}
