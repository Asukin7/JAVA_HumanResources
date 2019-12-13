package com.hr.dao;

import com.hr.entity.HrPostTransfer;

import java.util.List;
import java.util.Map;

public interface HrPostTransferDao {

    /**无参数查询所有岗位调动列表*/
    public List<HrPostTransfer> countList();

    /**带参数查询岗位调动列表*/
    public List<HrPostTransfer> list(Map<String,Object> map);

    /**根据主键查询一份岗位调动*/
    public HrPostTransfer findById(Integer id);

    /**带参数查询岗位调动数量*/
    public Long getTotal(Map<String,Object> map);

    /**添加一份岗位调动*/
    public Integer add(HrPostTransfer hrPostTransfer);

    /**修改一份岗位调动*/
    public Integer update(HrPostTransfer hrPostTransfer);

    /**根据主键删除一份岗位调动*/
    public Integer delete(Integer id);

}
